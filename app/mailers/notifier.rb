class Notifier < ActionMailer::Base
  default :from => "notifications@marketplace.uchicago.edu"

  def renew listing
    @listing  = listing
    mail :to => @listing.seller.email
  end
end
