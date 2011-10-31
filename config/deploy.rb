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
after 'deploy:update_code', 'deploy:symlink_shared'
after "deploy:symlink_shared", "deploy:update_crontab"

namespace :deploy do
  desc "Restart #{codename}."
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Symlink shared configurations."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/initializers/secrets.rb #{release_path}/config/initializers/secrets.rb"
  end

  desc "Update the crontab."
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end