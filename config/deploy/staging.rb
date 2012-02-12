set :rails_env, 'staging'
set :deploy_to, "/var/www/#{application.downcase}-#{rails_env}"