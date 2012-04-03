class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can [:index, :read, :search, :free, :starred, :star, :unstar], :all
    can [:manage, :renew, :publish, :unpublish], :all if user.admin?

    can :create, User
    can [:manage, :change_password], User, :id => user.id
    cannot [:index, :update_role, :lock], User unless user.admin? # User index is for user moderation

    if user.has_role? 'seller'
      can :create, Listing
      can [:update, :renew, :publish, :unpublish], Listing, :seller_id => user.id
      can [:dashboard], User, :id => user.id
    end
  end
end
