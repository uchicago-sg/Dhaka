class Listing < ActiveRecord::Base
  MAX_IMAGES    = 9 # Maximum number of uploadable images

  # Available options for sorting
  ORDER_BY      = [['Most Recent', 'created_at DESC'], ['Lowest Price', 'listings.price ASC, created_at DESC'], ['Highest Price', 'listings.price DESC, created_at DESC']]
  ORDER_OPTIONS = []
  ORDER_BY.each_with_index do |e, i|
    ORDER_OPTIONS << [e[0], i]
  end
  DEFAULT_ORDER = ORDER_BY[0][1] # Most recent

  attr_accessible :description, :details, :price, :status, :images_attributes, :category_ids
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

  scope :with_images, joins(:images)
  scope :signed, joins(:seller).where('users.signed = ?', true)

  # Listing lifecycle
  scope :published,   where(:published => true)
  scope :unpublished, where(:published => false)
  scope :available,   where('listings.renewed_at >= ?', 1.week.ago)  # Less than a week old
  scope :renewable,   where(:renewed_at => 2.weeks.ago..1.week.ago)  # Between one and two weeks old
  scope :unexpired,   where('listings.renewed_at >= ?', 2.weeks.ago) # Less than two weeks old
  scope :expired,     where('listings.renewed_at < ?', 2.weeks.ago)  # More than two weeks old

  def expired?
    renewed_at < 2.weeks.ago
  end

  def unpublished?
    not published?
  end

  def renewable?
    return true if published? and renewed_at >= 2.weeks.ago and renewed_at < 1.week.ago
    false
  end

  def readable?
    return true if published and renewed_at >= 1.week.ago
    false
  end

  def self.searchable
    self.published.available
  end

  def renew
    self.renewed_at = Time.now
    self
  end

  def publish
    self.published = true
    self
  end

  def unpublish
    self.published = false
    self
  end

  def to_param
    permalink
  end

  def as_json options={}
    self.attributes.keep_if { |k,v| k != 'id' }
  end
end