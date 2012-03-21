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
