source :rubygems

gem 'rails', '~> 3.1.0.rc'          # Only the latest, baby
gem 'heroku'                        # Deployment platform
gem 'devise'                        # User authentication
gem 'cancan'                        # User authorization
gem 'kaminari'                      # Dead-simple pagination
gem 'rdiscount'                     # Markdown processor
gem 'high_voltage'                  # Easy static pages
gem 'paperclip'                     # Easy file attachments
gem 'sprockets', '>= 2.0.0.beta.12' # The asset pipline
gem 'sass-rails', '~> 3.1.0.rc'     # Like CSS, but better
gem 'coffee-script'                 # Like JavaScript, but better
gem 'coffee-filter'                 # Use CoffeeScript in HAML
gem 'jquery-rails'                  # You know what it is
gem 'uglifier'                      # Minifier for production
gem 'haml'                          # Slim and sexy templates
gem 'haml-rails'                    # Use HAML in generators
gem 'paper_trail'                   # For versioning, undo

gem 'ransack', :git => 'git://github.com/ernie/ransack.git'                               # Successor to MetaSearch
gem 'compass', :git => 'git://github.com/chriseppstein/compass.git', :branch => 'rails31' # Hotsauce
gem 'acts-as-taggable-on', :git => 'https://github.com/mbleigh/acts-as-taggable-on.git'   # Dead-simple tagging

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'ruby-debug19'
  gem 'timecop'
end

group :test do
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'turn', :require => false
end

group :production do
  gem 'thin'
  gem 'pg'
end