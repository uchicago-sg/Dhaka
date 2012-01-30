class Notifier < ActionMailer::Base
  default :from => "no-reply@marketplace.uchicago.edu"

  def renew listing
    @listing  = listing
    mail :to => @listing.seller.email
  end
end