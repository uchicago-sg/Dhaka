class Category < ActiveRecord::Base
  attr_accessible :description, :details
  has_and_belongs_to_many :listings

  def to_param
    "#{id}-#{description.downcase.gsub( /[^\w\s]+/, '' ).gsub( /\s+/, '-' )}"
  end
end
