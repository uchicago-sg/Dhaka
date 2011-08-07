class User < ActiveRecord::Base
  attr_accessible :reference_id, :name, :email, :password, :password_confirmation, :remember_me
  has_many :listings, :foreign_key => 'seller_id'
  acts_as_tagger

  attr_readonly :permalink
  @@permalink_field = :name

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates :name,
    :presence => true,
    :format   => {
      :with    => /\A[\w \.\-]+\z/,
      :message => 'may only contain on alphanumeric characters, spaces, dashes, and underscores'
    }

  # Simple roles setup for use with CanCan
  scope :with_role, lambda { |role|
    { :conditions => "roles_mask & #{role.to_role} > 0" }
  }

  def roles= new_roles
    self.roles_mask = (new_roles & ROLES).map(&:to_role).sum
  end

  def roles
    ROLES.reject { |r| ((self.roles_mask || 0) & r.to_role).zero? }
  end

  def has_role? role
    roles.include? role
  end

  def admin?
    has_role? 'admin'
  end

  def signed?
    false
  end

  def to_param
    permalink
  end
end