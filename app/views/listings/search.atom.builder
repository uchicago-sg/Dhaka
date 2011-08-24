atom_feed :language => 'en-US' do |feed|
  feed.title "#{SITE_NAME} - Custom Search"
  feed.updated Time.now

  @listings.each do |item|
    feed.entry item do |entry|
      entry.title "#{item.description} - $#{item.price}"
      entry.content item.details
      entry.author do |author|
        author.name item.seller.name
      end
    end
  end
end