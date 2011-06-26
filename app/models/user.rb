class User < ActiveRecord::Base
  ROLES = %w( admin buyer seller )
  acts_as_tagger

  # Include default devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  scope :with_role, lambda { |role|
    { :conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0" }
  }

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((self.roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role_symbols
    roles.map(&:to_sym)
  end

  def has_role?(role)
    role_symbols.include? role.to_sym
  end

  def admin?
    has_role? 'admin'
  end

  def to_s
    name
  end
end