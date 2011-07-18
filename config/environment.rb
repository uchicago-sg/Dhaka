# Load the rails application
require File.expand_path('../application', __FILE__)

Time::DATE_FORMATS.merge!({
  :default => '%b %d, %Y at %H:%M'
})

SITE_NAME      = 'Marketplace'
STATIC_PAGES   = %w( terms privacy safety issues about faqs status )
DEVISE_PAGES   = %w( register login logout )
RESERVED_PATHS = STATIC_PAGES + DEVISE_PAGES + \
  %w( versions browse search users categories listings ) # Controller names

# Initialize the rails application
Dhaka::Application.initialize!