class Listing < ActiveRecord::Base
  attr_accessible :description, :details, :price, :status
  belongs_to :seller, :class_name => 'User'
  has_and_belongs_to_many :categories
  acts_as_taggable
  @@permalink_field = :description

  validates :description, :uniqueness => { :case_sensitive => false, :message => '' }
  validates :price, :numericality => { :only_integer => true, :greater_tan_or_equal_to => 0 }

  def to_param
    permalink
  end
end