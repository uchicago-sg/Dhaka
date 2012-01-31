$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path
require 'rvm/capistrano'                               # Load RVM's capistrano plugin
require 'whenever/capistrano'
require 'bundler/capistrano'
require './config/initializers/secrets.rb'

set :codename, 'Dhaka'
set :application, 'Marketplace'
set :domain, 'delphi.uchicago.edu:61527'
set :user, SERVER_ACCOUNT
set :use_sudo, false

set :scm, :git
set :branch, 'develop'
set :repository, "git://github.com/sczizzo/#{codename}.git"

set :rvm_ruby_string, "1.9.3"
set :rvm_type, :system

set :stage, 'production'
set :rails_env, stage
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/#{codename}/"

set :whenever_command, 'bundle exec whenever'

server domain, :app, :web
role :db, domain, :primary => true
after 'deploy:update_code', 'deploy:symlink_shared'

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
end