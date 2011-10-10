$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path
require 'rvm/capistrano'                               # Load RVM's capistrano plugin
require 'bundler/capistrano'

set :codename, 'Dhaka'
set :application, 'ScheduleSpy'
set :domain, 'sg.uchicago.edu'
set :user, 'sclemmer'
set :use_sudo, false

set :scm, :git
set :branch, 'develop'
set :repository, "git://github.com/sczizzo/#{codename}.git"

set :rvm_ruby_string, "1.9.2"
set :rvm_type, :user

set :stage, 'production'
set :rails_env, stage
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/#{codename}/"

server domain, :app, :web
role :db, domain, :primary => true
after :deploy, 'passenger:restart'

# From railscast on cron jobs
after "deploy:symlink", "deploy:update_crontab"
namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end

namespace :passenger do
  desc "Restart #{codename}."
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end