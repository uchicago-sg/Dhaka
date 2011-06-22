class Listing < ActiveRecord::Base
  attr_accessible :description, :details, :price, :status

  def price_in_dollars( amount_in_cents )
    amount_in_cents / 1000
  end

  def price_in_dollars=( amount_in_cents )
    price = ( amount_in_cents * 100 ).to_i
  end
end
