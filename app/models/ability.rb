class Ability
  include CanCan::Ability

  def initialize(user)

    # ---- defaults ----

    cannot :manage, Course
    cannot :manage, Institution
    cannot :manage, User

    # ---- each ----

    if user.admin?
      can :manage, Course, institution_id: user.institution_id
      can :manage, Institution
      can :manage, User
    elsif user.schoolmaster?
      can :manage, Course, institution_id: user.institution_id
      can :manage, Institution, id: user.institution_id
    elsif user.coordinator?
      can :manage, Course, coordinator_id: user.id
    end

  end
end
