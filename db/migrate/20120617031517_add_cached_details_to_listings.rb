class AddCachedDetailsToListings < ActiveRecord::Migration
  def change
    add_column :listings, :cached_details, :text
  end
end
