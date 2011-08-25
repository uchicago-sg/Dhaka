atom_feed :language => 'en-US' do |feed|
  render :partial => 'shared/listings', :locals => {
    :feed       => feed,
    :feed_title => 'All Categories',
    :feed_items => @listings
  }
end