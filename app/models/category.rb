class Category < ActiveRecord::Base
  attr_accessible :description, :details
  has_and_belongs_to_many :listings
  @@permalink_field = :description

  validates :description,
    :presence   => true,
    :uniqueness => { :case_sensitive => false }

  def to_param
    permalink
  end
end