# set :environment => 'development'
# set :output, "path/to/cron/log"

every 1.day do
  runner "Listing.remove_expired_images"
  runner "Listing.notify_almost_renewable"
end