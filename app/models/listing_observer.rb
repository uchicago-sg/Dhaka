require 'active_support/secure_random'

class ListingObserver < ActiveRecord::Observer
  def before_create record
    record.reference_id = ActiveSupport::SecureRandom.base64(16)
  end
end