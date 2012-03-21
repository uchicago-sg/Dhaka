class Notifier < ActionMailer::Base
  default :from     => 'noreply@marketplace.uchicago.edu'
  default :reply_to => 'noreply@marketplace.uchicago.edu'

  def ready_to_renew listing
    @listing  = listing
    mail :subject => 'Marketplace: Listing ready to renew', :to => @listing.seller.email
  end
end
