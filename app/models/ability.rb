class Ability
  include CanCan::Ability

  def initialize(user)

    # ---- defaults ----

    cannot :manage, Course
    cannot :manage, Institution
    cannot :manage, User

    cannot :manage, :admin_dashboard
    cannot :manage, :teachers_dashboard
    cannot :manage, :admin_users
    cannot :manage, :teachers_users

    # ---- user types ----

    if user.admin?
      can :manage, Institution
      can :manage, User

      can :manage, :admin_dashboard
    end

    if user.schoolmaster?
      can :manage, Course, institution_id: user.institution_id
      can :manage, Subject, institution_id: user.institution_id
      can :manage, User, institution_id: user.institution_id

      can :manage, :teachers_dashboard
    end

    if user.coordinator?
      can :manage, Subject, course_id: user.coordinated_course_id

      can :manage, :teachers_dashboard
    end

    if user.teacher?
      can :manage, :teachers_dashboard
    end

    if user.student?
      can :manage, :students_dashboard
    end
  end
end
