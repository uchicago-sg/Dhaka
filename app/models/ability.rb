class Ability
  include CanCan::Ability

  # Should really change this later...
  def initialize(user)
    user ||= User.new
    can :read, :all
    can :manage, :all if user.admin?
  end
end
