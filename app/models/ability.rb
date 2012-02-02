class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can [:manage, :renew, :publish, :unpublish], :all if user.admin?
    can [:index, :read, :search, :starred, :star, :unstar], :all
    can :create, User
    can [:manage, :change_password], User, :id => user.id

    if user.has_role? 'seller'
      can :create, Listing
      can [:update, :renew, :publish, :unpublish], Listing, :seller_id => user.id
      can [:dashboard], User, :id => user.id
    end
  end
end