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
  # FYI There may be some incredibly small (like milliseconds) overlap here...
  scope :unexpired, where('listings.renewed_at >= ?', 1.week.ago)
  scope :expired,   where(:renewed_at => 2.weeks.ago..1.week.ago)
  scope :retiring,  where('listings.renewed_at < ?', 2.weeks.ago)

  # Check your scopes, because retired listings are exluded by default
  default_scope where('listings.renewed_at >= ? AND listings.expired = ?', 2.weeks.ago, false)

  def renewable?
    if expired == false
      if renewed_at >= 2.weeks.ago
        if renewed_at < 1.week.ago
          return true
        end
      end
    end
    false
  end

  def renew
    self.renewed_at = Time.now
    self
  end

  # An unfortunate name, looking back on it, as we've already got an "expired" scope
  # Think of this as an explicit expiration flag
  def expire
    self.expired = true
    self
  end

  def unexpire
    self.expired = false
    self
  end

  def explicitly_expired?
    expired?
  end

  scope :explicitly_expiring, where(:expired => true)
  def self.explicitly_expired
    unscoped.explicitly_expiring
  end

  def self.retired
    unscoped.retiring
  end

  def to_param
    permalink
  end

  def as_json options={}
    self.attributes.keep_if { |k,v| k != 'id' }
  end
end