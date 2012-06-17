class ListingObserver < ActiveRecord::Observer
  def before_create record
    record.renewed_at = Time.now
  end

  def before_save record
    # Will come out doubly encoded by strip_tags if we don't decode
    coder = HTMLEntities.new
    record.details = coder.decode record.details
    record.cached_details = record.details.markdown.strip
  end
end