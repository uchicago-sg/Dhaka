class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Profile.new
    can :manage, :all
  end
end
