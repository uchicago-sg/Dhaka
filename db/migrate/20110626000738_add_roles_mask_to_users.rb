class AddRolesMaskToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :roles_mask, :integer, :default => DEFAULT_ROLE, :null => false
  end
end
