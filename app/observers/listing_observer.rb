require 'active_support/secure_random'

class ListingObserver < ActiveRecord::Observer
  def before_create record
    record.renewed_at   = Time.now
    record.reference_id = ActiveSupport::SecureRandom.base64 16
  end
end