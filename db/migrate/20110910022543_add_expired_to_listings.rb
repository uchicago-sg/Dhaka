class AddExpiredToListings < ActiveRecord::Migration
  def change
    add_column :listings, :expired, :boolean, :default => false
  end
end
