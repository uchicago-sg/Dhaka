class CreateListingsCategoriesTable < ActiveRecord::Migration
  def up
    create_table :listings_categories, :id => false do |t|
      t.references :listing
      t.references :category
    end

    add_index :listings_categories, [:listing_id, :category_id]
    add_index :listings_categories, [:category_id, :listing_id]
  end

  def down
    drop_table :listings_categories
  end
end
