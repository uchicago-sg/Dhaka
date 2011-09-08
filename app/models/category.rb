class Category < ActiveRecord::Base
  attr_accessible :description, :details
  has_and_belongs_to_many :listings

  validates :description,
    :presence   => true,
    :uniqueness => { :case_sensitive => false }

  # For sexier URLs
  attr_readonly :permalink
  @@permalink_field = :description

  def to_param
    permalink
  end

  # Protect the ID when outputting
  def as_json options={}
    self.attributes.keep_if { |k,v| k != 'id' }
  end
end