class Listing < ActiveRecord::Base
  attr_accessible :description, :details, :price, :status
  belongs_to :seller, :class_name => 'User'
  has_and_belongs_to_many :categories
  acts_as_taggable
  @@permalink_field = :description

  def to_param
    permalink
  end
end