class Notifier < ActionMailer::Base
  default :from     => 'sclemmer@uchicago.edu'
  default :reply_to => 'sclemmer@uchicago.edu'

  def ready_to_renew listing
    @listing  = listing
    mail :subject => 'Marketplace: Listing ready to renew', :to => @listing.seller.email
  end
end
