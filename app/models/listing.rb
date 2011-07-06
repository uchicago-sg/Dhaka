class Listing < ActiveRecord::Base
  attr_accessible :description, :details, :price, :status
  belongs_to :seller, :class_name => 'User'
  belongs_to :category
  acts_as_taggable

  def to_param
    "#{id}-#{description.downcase.gsub( /[^\w\s]+/, '' ).gsub( /\s+/, '-' )}"
  end
end