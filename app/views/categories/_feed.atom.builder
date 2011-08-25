atom_feed :language => 'en-US' do |feed|
  feed.title "#{SITE_NAME} - #{feed_title}"
  feed.updated Time.now

  feed_items.each do |item|
    feed.entry item do |entry|
      entry.title "#{item.description} - $#{item.price.zero? ? 'Free' : number_to_currency(item.price)}"
      entry.content item.details
      entry.author do |author|
        author.name item.seller.name
      end
    end
  end
end