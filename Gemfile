source :rubygems

gem 'rails'
gem 'rack', '1.3.3' # Fix 'already initialized constant WFKV_' warnings
gem 'capistrano'
gem 'sqlite3'
gem 'rspec-rails'
gem 'ruby-debug19'
gem 'timecop'
gem 'therubyracer'

gem 'foreman'        # Simple process management
gem 'cancan'         # User authorization
gem 'rdiscount'      # Markdown processor
gem 'high_voltage'   # Easy static pages
gem 'paperclip'      # Easy file attachments
gem 'paper_trail'    # For versioning, undo
gem 'nokogiri'       # Scraping old marketplace
gem 'devise'         # User authentication
gem 'ransack'        # Successor to MetaSearch
gem 'impressionist'  # Simple page view counter

gem 'whenever', :require => false
gem 'htmlentities'
gem 'rinku'

gem 'acts-as-taggable-on', :git => 'https://github.com/mbleigh/acts-as-taggable-on.git' # Dead-simple tagging
gem 'kaminari', :git => 'git://github.com/amatsuda/kaminari'                            # Dead-simple pagination

group :assets do
  gem 'sprockets'     # The asset pipline
  gem 'coffee-script' # Like JavaScript, but better
  gem 'coffee-filter' # Use CoffeeScript in HAML
  gem 'jquery-rails'  # You know what it is
  gem 'uglifier'      # Minifier for production
  gem 'haml'          # Slim and sexy templates
  gem 'haml-rails'    # Use HAML in generators
  gem 'tinymce-rails' # Simple WYSIWYG editor

  gem 'sass-rails', '>= 3.1.4'
  gem 'compass', :git => 'git://github.com/chriseppstein/compass.git', :tag => 'v0.12.alpha.0'
end

group :test do
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'turn', :require => false
end