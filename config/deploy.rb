$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path
require 'rvm/capistrano'                               # Load RVM's capistrano plugin
require 'bundler/capistrano'

set :codename, 'Dhaka'
set :application, 'ScheduleSpy'
set :domain, 'schedulespy.com'
set :hostname, 'saluki'
set :port, 6132
set :user, 'deploy'
set :use_sudo, false
ssh_options[:forward_agent] = true

set :scm, :git
set :branch, 'develop'
set :repository, "git@github.com:sczizzo/#{codename}.git"
set :rvm_ruby_string, "1.9.2@#{codename.downcase}"

set :stage, 'production'
set :rails_env, stage
set :deploy_via, :remote_cache
set :deploy_to, "/var/deploy/#{codename}/#{stage}"

server domain, :app, :web
role :db, domain, :primary => true
after :deploy, 'passenger:restart'

namespace :passenger do
  desc "Restart #{codename}."
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end