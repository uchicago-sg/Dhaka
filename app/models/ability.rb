class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, :all if user.admin?
    can :read, :all
    can :serach, :all
    can :create, User

    if user.has_role? 'seller'
      can :create, Listing
      can :update, Listing, :seller_id => user.id
      can :renew,  Listing, :seller_id => user.id
      can :expire, Listing, :seller_id => user.id
      can :manage, User, :id => user.id
    end
  end
end