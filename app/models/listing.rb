class Listing < ActiveRecord::Base
  attr_accessible :description, :details, :price, :status, :images_attributes
  belongs_to :seller, :class_name => 'User'
  has_and_belongs_to_many :categories
  has_many :images, :dependent => :destroy
  accepts_nested_attributes_for :images, :allow_destroy => :true
  has_paper_trail
  acts_as_taggable

  attr_readonly :permalink
  @@permalink_field = :description

  validates :description, :presence => true
  validates :details, :presence => true
  validates :price,
    :numericality => {
      :greater_tan_or_equal_to => 0,
      :message => 'must be a number >= 0'
    }

  scope :with_images, joins(:images).group('listings.id')
  scope :signed, joins(:seller).where('users.signed = ?', true)
  scope :unexpired, where('listings.created_at >= ?', 1.week.ago)

  def self.expired
    unscoped.where 'listings.created_at < ?', 1.week.ago
  end

  def to_param
    permalink
  end

  def as_json options={}
    self.attributes.keep_if { |k,v| k != 'id' }
  end
end