atom_feed :language => 'en-US' do |feed|
  feed.title "Marketplace - #{@title}"
  feed.updated Time.now

  @listings.each do |item|

    feed.entry( item ) do |entry|
      entry.url listing_url(item)
      entry.title "#{item.description} - $#{item.price}"
      entry.content item.details

      # the strftime is needed to work with Google Reader.
      entry.updated(item.created_at.strftime("%Y-%m-%dT%H:%M:%SZ")) 
      entry.author item.seller.name
      
    end
  end
end