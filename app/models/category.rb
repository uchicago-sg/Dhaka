class Category < ActiveRecord::Base
  attr_accessible :description, :details
  has_many :listings
end
