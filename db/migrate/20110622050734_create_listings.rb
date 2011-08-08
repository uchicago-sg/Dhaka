class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :description
      t.text :details
      t.decimal :price, :precision => 8, :scale => 2, :default => 0
      t.integer :status
      t.references :seller

      t.timestamps
    end
  end
end