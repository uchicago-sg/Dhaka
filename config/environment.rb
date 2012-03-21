# Load the rails application
require File.expand_path('../mailjet', __FILE__)
require File.expand_path('../application', __FILE__)
require 'rails_rinku'

# Configure Gmail support
ActionMailer::Base.smtp_settings = {
  :domain               => 'marketplace.uchicago.edu',
  :address              => MAILJET_HOST,
  :port                 => MAILJET_PORT,
  :user_name            => MAILJET_ACCOUNT,
  :password             => MAILJET_PASSWORD,
  :authentication       => 'plain',
  :enable_starttls_auto => true
}

module Kaminari
  module Helpers
    class Tag
      def page_url_for(page)
        @template.url_for @template.params.merge(@param_name => (page < 1 ? nil : page))
      end
    end
  end
end


# Predefined roles for CanCan
ROLES = %w( admin buyer seller )

class String
  def role?
    ROLES.include?(self)
  end

  def to_role
    role? ? 2 ** ROLES.index(self) : 0
  end
end

DEFAULT_ROLE = 'buyer'.to_role

# Generate a slug suitable for permalinks
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

# Run a string through the Markdown filter and return for output
class String
  def markdown
    Rinku.auto_link(RDiscount.new(self).to_html, :urls).html_safe
  end
end


# Add custom date formatters
Time::DATE_FORMATS.merge!({
  :default => '%b %d, %Y at %H:%M'
})

# Unfortunate but useful contstants
SITE_NAME      = 'Marketplace'
APP_RESOURCES  = %w( listings users categories )
STATIC_PAGES   = %w( terms privacy safety issues about faqs status welcome )
DEVISE_PAGES   = %w( register login logout )
RESERVED_PATHS = STATIC_PAGES + DEVISE_PAGES + \
  %w( versions browse search users categories listings starred dashboard index show new create edit update delete ) # Special routes

# Wrap errors in <span>s instead of <div>s
ActionView::Base.field_error_proc = Proc.new { |html_tag, instance| "<span class='field_with_errors'>#{html_tag}</span>".html_safe }

# Initialize the rails application
Dhaka::Application.initialize!
