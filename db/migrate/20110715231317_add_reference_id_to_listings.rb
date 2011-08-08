class AddReferenceIdToListings < ActiveRecord::Migration
  def change
    add_column :listings, :reference_id, :string
  end
end
