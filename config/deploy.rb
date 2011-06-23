$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
require 'bundler/capistrano'
require 'capistrano/ext/multistage'


set :application, 'Dhaka'

set :domain, 'schedulespy.com'
set :hostname, 'saluki'
set :port, 6132
set :user, 'deploy'
set :use_sudo, false
ssh_options[:forward_agent] = true

set :scm, :git
set :repository, "ssh://#{user}@#{domain}:#{port}/home/#{user}/#{application}"
set :rvm_ruby_string, "1.9.2@#{application.downcase}"

set :default_stage, 'staging'
set :rails_env, default_stage
set :deploy_to, "/var/deploy/#{application}"
set :deploy_via, :remote_cache

role :web, 'schedulespy.com'
role :app, 'schedulespy.com'
role :db,  'schedulespy.com', :primary => true

namespace :deploy do
  %w( start stop restart ).each do |action|
     desc "Send the '#{action}' message to the server(s)."
     task action.to_sym do
       find_and_execute_task( "thin:#{action}" )
    end
  end
end

namespace :thin do
  %w( start stop restart ).each do |action|
  desc "#{action.capitalize} thin's cluster of servers."
    task action.to_sym, :roles => :app do
      run "thin #{action} --chdir #{deploy_to}/current --config #{deploy_to}/current/config/deploy/#{default_stage}.yml"
    end
  end
end