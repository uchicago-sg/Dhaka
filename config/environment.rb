# Load the rails application
require File.expand_path('../application', __FILE__)

# See http://stackoverflow.com/questions/1302022/best-way-to-generate-slugs-human-readable-ids-in-rails
# and https://github.com/ludo/to_slug/
class String
  def to_slug
    slug = self.mb_chars.normalize :kd # Normalize mutlibyte characters
    slug.gsub! /[^\x00-\x7F]/n, ''     # Strip ugly non-ASCII stuff
    slug.gsub! /['`]/, ''              # Remove quotes
    slug.gsub! '@', ' at '             # Preserve meaning of the at symbol
    slug.gsub! '&', ' and '            # ...and the ampersand
    slug.gsub! /\W+/, ' '              # Convert non-word characters to spaces
    slug.strip!                        # Strip leading and trailing spaces
    slug.gsub! /\s+/, '-'              # Convert whitespace to dashes
    slug.downcase                      # Oh yeah, and lowercase
  end
end

# Add custom date formatters
Time::DATE_FORMATS.merge!({
  :default => '%b %d, %Y at %H:%M'
})

# Unfortunate but useful contstants
SITE_NAME      = 'Marketplace'
STATIC_PAGES   = %w( terms privacy safety issues about faqs status )
DEVISE_PAGES   = %w( register login logout )
RESERVED_PATHS = STATIC_PAGES + DEVISE_PAGES + \
  %w( versions browse search users categories listings ) # Controller names

# Initialize the rails application
Dhaka::Application.initialize!