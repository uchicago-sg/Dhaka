every 1.day, :at => '1:00 am' do
  runner "Listing.remove_expired_images"
  runner "Listing.notify_almost_renewable"
end

every 1.hour do
  runner "Listing.find_dupes"
end