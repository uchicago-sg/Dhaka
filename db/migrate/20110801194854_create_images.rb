class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :listing

      t.timestamps
    end
    add_index :images, :listing_id
  end
end
