class ListingObserver < ActiveRecord::Observer
  def before_create record
    record.renewed_at = Time.now
  end
end