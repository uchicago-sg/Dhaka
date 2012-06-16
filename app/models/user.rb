class User < ActiveRecord::Base
  attr_accessible :reference_id, :name, :email, :password, :password_confirmation, :remember_me
  has_many :listings, :foreign_key => 'seller_id', :dependent => :destroy
  acts_as_tagger

  attr_readonly :permalink
  @@permalink_field = :name

  devise :token_authenticatable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, 
         :lockable, :unlock_strategy => :none, :lock_strategy => :none
  # before_save :ensure_authentication_token

  validates :name,
    :presence => true,
    :format   => {
      :with    => /\A[\w \.\-]+\z/,
      :message => 'may only contain on alphanumeric characters, spaces, dashes, and underscores'
    }

  # Simple roles setup for use with CanCan
  scope :with_role, lambda { |role|
    { :conditions => ["roles_mask & ? > 0", role.to_role] }
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
  
  def toggle_role role
    self.roles_mask = self.roles_mask^(role.to_role)
  end
  
  def toggle_lock
    access_locked? ? unlock_access! : lock_access!
  end
  
  def admin?
    has_role? 'admin'
  end
  
  def seller?
    has_role? 'seller'
  end

  def signed?
    signed
  end

  # Make can? available to models
  # See http://stackoverflow.com/questions/3293400/access-cancans-can-method-from-a-model
  def ability
    @ability ||= Ability.new(self)
  end

  delegate :can?, :cannot?, :to => :ability

  def to_param
    permalink
  end

  def as_json options={}
    result = self.attributes.keep_if { |k,v| k == 'email' or k == 'name' or k == 'permalink' or k == 'signed' }
    result[:listings] = self.listings
    result
  end
end