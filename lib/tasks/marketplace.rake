task :marketplace_seed => [:environment] do 
  require 'nokogiri'
  require 'open-uri'     
  doc = Nokogiri::HTML( open( 'http://marketplace.uchicago.edu/category.php?category=electronics' ) )
  products = []
  doc.css('a[@href*="listing.php"]').each do |listing| 
    products << listing.content
  end
  prices = []
  doc.xpath('//td').each do |row|
    prices <<  row.content.scan(/\$(\d?\d?\d?\d?)/)
  end
  
  # Hack-tastic, don't even bother
  prices = prices[1].flatten
  
  products.each_with_index do |p, index|
    Listing.create({
      :description => p,
      :details     => 'Etiam sit amet dictum lectus. Curabitur vitae dignissim odio. Duis massa urna, dapibus at sollicitudin vel, lacinia et ante.',
      :price       => prices[index].to_i,
      :seller      => User.first,
      :categories  => [Category.all[2]]
    })
  end
end
