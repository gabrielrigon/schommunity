class Ability
  include CanCan::Ability

  def initialize(user)

    # ---- defaults ----

    cannot :manage, Classroom
    cannot :manage, Course
    cannot :manage, Institution
    cannot :manage, Subject
    cannot :manage, User

    cannot :manage, :admin_dashboard
    cannot :manage, :students_dashboard
    cannot :manage, :teachers_dashboard

    cannot :manage, :admin_users
    cannot :manage, :teachers_users

    # ---- user types ----

    if user.admin?
      can :manage, Institution
      can :manage, User

      can :manage, :admin_dashboard
      can :manage, :admin_users
    end

    if user.schoolmaster?
      can :manage, Classroom, institution_id: user.institution_id
      can :manage, Course,    institution_id: user.institution_id
      can :manage, Subject,   institution_id: user.institution_id
      can :manage, User,      institution_id: user.institution_id

      can :manage, :teachers_dashboard
      can :manage, :teachers_users
    end

    if user.coordinator?
      can :manage, Classroom, course_id: user.coordinated_courses_ids
      can :manage, Subject,   course_id: user.coordinated_courses_ids

      can :manage, :teachers_dashboard
    end

    if user.teacher?
      can :manage, Classroom, course_id: user.coordinated_courses_ids

      can :manage, :teachers_dashboard
    end

    if user.student?
      can :manage, :students_dashboard
    end
  end
end
