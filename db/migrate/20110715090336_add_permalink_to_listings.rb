class AddPermalinkToListings < ActiveRecord::Migration
  def change
    add_column :listings, :permalink, :string
  end
end
