class Category < ActiveRecord::Base
  attr_accessible :description, :details
  has_and_belongs_to_many :listings

  attr_readonly :permalink
  @@permalink_field = :description

  validates :description,
    :presence   => true,
    :uniqueness => { :case_sensitive => false }

  def to_param
    permalink
  end

  def as_json options={}
    self.attributes.keep_if { |k,v| k != 'id' }
  end
end