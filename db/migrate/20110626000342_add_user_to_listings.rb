class AddUserToListings < ActiveRecord::Migration
  def self.up
    add_column :listings, :seller, :integer
  end
end
