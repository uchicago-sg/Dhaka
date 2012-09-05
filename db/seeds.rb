require 'json'

users = JSON.parse File.read('db/users.json')
categories = JSON.parse File.read('db/categories.json')

categories.each do |c|
  r = Category.new
  r.description = c['description']
  r.details = c['details']
  r.save
end


users.each do |u|
  r = User.new
  r.email = u['email']
  r.name = u['name']
  r.password = '123456'
  r.save

  u['listings'].take(2).each do |l|
    s = Listing.new
    s.seller = r
    s.description = l['description']
    s.details = l['details']
    s.price = l['price'].to_i
    s.save
  end
end