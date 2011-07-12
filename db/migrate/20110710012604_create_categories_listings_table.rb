class CreateCategoriesListingsTable < ActiveRecord::Migration
  def up
    create_table :categories_listings, :id => false do |t|
      t.references :listing
      t.references :category
    end

    add_index :categories_listings, [:listing_id, :category_id]
    add_index :categories_listings, [:category_id, :listing_id]
  end

  def down
    drop_table :categories_listings
  end
end
