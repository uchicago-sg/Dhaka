class DuplicateSweeper < ActionController::Caching::Sweeper
  observe Listing
end