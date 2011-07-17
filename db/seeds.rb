# The real seeds...
[
  ['Apartments',    'Apartments'],
  ['Subleases',     'Subleases'],
  ['Appliances',    'Appliances'],
  ['Bikes',         'Bikes'],
  ['Books',         'Hardbacks, paperbacks, textbooks'],
  ['Cars',          'Cars, motorcycles'],
  ['Electronics',   'Computers, TVs, personal electronics'],
  ['Employment',    'Job opportunities'],
  ['Furniture',     'Couches, chairs, bookshelves'],
  ['Miscellaneous', 'Catch-all'],
  ['Services',      'Odd jobs, advertisements'],
  ['Wanted',        'Looking for...']
].each do |category_with_description|
  Category.new({
    :description => category_with_description[0],
    :details     => category_with_description[1]
  }).save!
end



# For testing only!
admin = User.new({
  :name     => 'admin',
  :email    => 'admin@marketplace.uchicago.edu',
  :password => '123456'
})

admin.roles = %w( admin )
admin.save!


sean = User.new({
  :name     => 'sczizzo',
  :email    => 'sczizzo@gmail.com',
  :password => 'seaman01'
})

sean.roles = %w( seller )
sean.save!


paul = User.new({
  :name     => 'plkap74',
  :email    => 'plkap74@uchicago.edu',
  :password => 'fishnets'
})

paul.roles = %w( seller )
paul.save!


listing1 = Listing.new({
  :description => 'Bicycle Seat',
  :details     => 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Sed pretium tincidunt nisi at auctor. Proin vehicula pulvinar augue, vel laoreet erat dapibus et.',
  :price       => 40000
})

listing1.seller     = sean
listing1.categories = [Category.all[0], Category.all[3]]
listing1.save!


listing2 = Listing.new({
  :description => 'New couch cushions',
  :details     => 'Etiam sit amet dictum lectus. Curabitur vitae dignissim odio. Duis massa urna, dapibus at sollicitudin vel, lacinia et ante.',
  :price       => 550000
})

listing2.seller     = paul
listing2.categories = [Category.all[2], Category.all[8], Category.all[5]]
listing2.save!
