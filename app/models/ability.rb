class Ability
  include CanCan::Ability

  def initialize(user)

    # ---- defaults / can ----

    can :manage, Course, institution_id: user.institution.id

    # ---- defaults / cannot ----

    cannot :manage, Institution
    cannot :manage, User

    # ---- admin ----

    if user.admin?
      can :manage, Institution
      can :manage, User
    end

  end
end
