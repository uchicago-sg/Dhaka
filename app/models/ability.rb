class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can [:manage, :renew, :publish, :unpublish], :all if user.admin?
    can [:read, :search], :all
    can :create, User

    if user.has_role? 'seller'
      can :create, Listing
      can [:update, :renew, :publish, :unpublish], Listing, :seller_id => user.id
      can :manage, User, :id => user.id
    end
  end
end