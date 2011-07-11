class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :description
      t.text :details
      t.integer :price
      t.integer :status
      t.references :seller

      t.timestamps
    end
  end
end