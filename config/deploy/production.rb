set :default_stage, 'production'
set :deploy_to, "/var/deploy/#{application}/#{default_stage}"
set :rails_env, default_stage