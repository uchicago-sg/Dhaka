class AddSignedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :signed, :boolean, :default => false
  end
end
