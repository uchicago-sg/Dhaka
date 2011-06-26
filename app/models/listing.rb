class Listing < ActiveRecord::Base
  acts_as_taggable # Replaces old notion of 'categories'
  attr_accessible :description, :details, :price, :status
  belongs_to :seller, :class_name => 'User'

  def price_dollars(amount_in_cents)
    amount_in_cents / 100
  end

  def price_dollars=(amount_in_cents)
    price = (amount_in_cents * 100).to_i
  end

  def to_param
    "#{id}-#{description.downcase.gsub( /[^\w\s]+/, '' ).gsub( /\s+/, '-' )}"
  end
end