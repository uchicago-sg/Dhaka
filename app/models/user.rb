class User < ActiveRecord::Base
  attr_accessible :reference_id, :name, :email, :password, :password_confirmation, :remember_me
  has_many :listings, :foreign_key => 'seller_id', :dependent => :destroy
  acts_as_tagger

  attr_readonly :permalink
  @@permalink_field = :name

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable, 
         :confirmable,
         :lockable,
         :unlock_strategy => :none,
         :lock_strategy => :none

  # before_save :ensure_authentication_token

  validates :name,
    :presence => true,
    :format   => {
      :with    => /\A[\w \.\-]+\z/,
      :message => 'may only contain on alphanumeric characters, spaces, dashes, and underscores'
    }

  validates :email,
    :on       => :create,
    :format   => {
      :with => /\A.+@(.+\.)*(uchicago\.edu|uchospitals\.edu|chicagobooth\.edu)\z/i,
      :message => 'must be an @uchicago.edu, @uchospitals.edu, or @chicagobooth.edu address'
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

  def has_role? role ; roles.include? role end
  
  def toggle_role role ; self.roles_mask = self.roles_mask ^ role.to_role end
  
  def toggle_lock ; access_locked? ? unlock_access! : lock_access! end
  
  def admin? ; has_role? 'admin' end
  
  def seller? ; has_role? 'seller' end

  def signed? ; signed end

  # Make can? available to models
  # See http://stackoverflow.com/questions/3293400/access-cancans-can-method-from-a-model
  def ability ; @ability ||= Ability.new(self) end

  delegate :can?, :cannot?, :to => :ability

  def self.confirmed ; where 'confirmed_at IS NOT NULL' end

  def self.unconfirmed ; where 'confirmed_at IS NULL' end

  def to_param ; permalink end

  def as_simplified_json options={}
    result = self.attributes.keep_if do |k,v|
      k == 'email' or
      k == 'name' or
      k == 'permalink'
    end
    result
  end

  def as_json options={}
    result = as_simplified_json options
    result[:listings] = self.listings.map &:as_simplified_json
    result
  end


  # Override Devise's confirmation instructions
  # Prevent users from submitting more than once in 24 hours
  def send_confirmation_instructions
    self.confirmation_token = nil if reconfirmation_required?
    @reconfirmation_required = false

    last_confirmation_sent_at = confirmation_sent_at || 0
    diff = Time.now - last_confirmation_sent_at
    if diff > 20.seconds and diff < 24.hours
      self.errors.add(:email, :recently_confirmed)
      return
    end

    generate_confirmation_token! if self.confirmation_token.blank?
    send_devise_notification(:confirmation_instructions)
  end

  # Override Devise's password reset
  # Prevent users from submitting more than once in 24 hours
  def send_reset_password_instructions
    generate_reset_password_token! if should_generate_reset_token?
    send_devise_notification(:reset_password_instructions)

    last_reset_sent_at = reset_password_sent_at || 0
    diff = Time.now - last_reset_sent_at
    if diff > 20.seconds and diff < 24.hours
      self.errors.add(:email, :recently_reset)
      return
    end
  end
end