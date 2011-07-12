# Load the rails application
require File.expand_path('../application', __FILE__)

Time::DATE_FORMATS.merge!({
  :default => '%b %d, %Y at %H:%M'
})

SITE_NAME = 'Marketplace'

# Initialize the rails application
Dhaka::Application.initialize!
