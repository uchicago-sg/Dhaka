class Category < ActiveRecord::Base
  attr_accessible :description, :details
  has_and_belongs_to_many :listings
end
