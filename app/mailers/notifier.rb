class Notifier < ActionMailer::Base
  default :from     => 'noreply@marketplace.uchicago.edu'
  default :reply_to => 'noreply@marketplace.uchicago.edu'


  def renew listing
    @listing  = listing
    mail {
      :subject  => 'Marketplace: Listing expires tomorrow'
      :to       => @listing.seller.email,
    }
  end
end
