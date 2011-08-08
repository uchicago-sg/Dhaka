class AddRenewalsToListings < ActiveRecord::Migration
  def change
    add_column :listings, :renewed_at, :timestamp # Default set to Time.now in ListingObserver
    add_column :listings, :renewals, :integer, :default => 0
  end
end