class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    if user.admin?
      # Admins can do everything
      can :manage, :all
    elsif user.audiologist?
      # Audiologists can READ everything, but cannot edit/create/delete
      can :read, :all
    else
      # Patients can do nothing in the admin panel
    end
  end
end