admin = User.new({
  :name => 'sczizzo',
  :email => 'sczizzo@gmail.com',
  :password => 'seaman01'
})

admin.roles = %w( admin )
admin.save!

seller = User.new({
  :name => 'sclemmer',
  :email => 'sclemmer@uchicago.edu',
  :password => 'seaman01'
})

seller.roles = %w( seller )
seller.save!

listing = Listing.new({
  :description => 'ASDF',
  :details => '123456',
  :price => 40000
})

listing.seller = seller
listing.save!
