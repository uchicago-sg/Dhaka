class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can [:categories, :index, :read, :search, :free, :starred, :star, :unstar], :all
    can [:manage, :moderate, :renew, :publish, :unpublish], :all if user.admin?
    can :create, User
    can [:manage, :change_password], User, :id => user.id
    cannot [:index], User unless user.admin? # User index is for user moderation
    cannot [:update_role], User unless user.admin?

    if user.has_role? 'seller'
      can :create, Listing
      can [:update, :renew, :publish, :unpublish], Listing, :seller_id => user.id
      can [:dashboard], User, :id => user.id
    end
  end
end
