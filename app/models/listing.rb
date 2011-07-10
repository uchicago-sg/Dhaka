class Listing < ActiveRecord::Base
  attr_accessible :description, :details, :price, :status
  belongs_to :seller, :class_name => 'User'
  has_and_belongs_to_many :category
  acts_as_taggable

  def to_param
    "#{id}-#{description.downcase.gsub( /[^\w\s]+/, '' ).gsub( /\s+/, '-' )}"
  end
end