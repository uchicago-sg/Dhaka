source :rubygems

gem 'rails', '3.1.0.rc4'           # Only the latest, baby
gem 'capistrano'                   # For Saluki deployment
gem 'capistrano-ext'               # Useful for multistage deploys
gem 'thin'                         # Only the best
gem 'sqlite3'                      # Probably move to MySQL in production
gem 'devise'                       # User authentication
gem 'cancan'                       # User authorization
gem 'acts-as-taggable-on'          # Tags
gem 'rdiscount'                    # Markdown processor
gem 'high_voltage'                 # Easy static pages
gem 'paperclip'                    # Easy file attachments
gem 'sprockets', '= 2.0.0.beta.10' # The asset pipline
gem 'sass-rails', "~> 3.1.0.rc"    # Like CSS, but better
gem 'compass', :git => 'git://github.com/chriseppstein/compass.git', :branch => 'rails31' # Hotsauce
gem 'coffee-script'                # Like JavaScript, but better
gem 'jquery-rails'                 # You know what it is
gem 'uglifier'                     # Minifier for production

group :development, :test do
  gem 'rspec-rails'
  gem 'ruby-debug19'
end

group :test do
  gem 'factory_girl_rails'
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'turn', :require => false
end