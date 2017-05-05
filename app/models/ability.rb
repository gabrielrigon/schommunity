class Ability
  include CanCan::Ability

  def initialize(user)

    # ---- defaults ----

    can :manage, :user_profile

    cannot :manage, Classroom
    cannot :manage, Course
    cannot :manage, Institution
    cannot :manage, Post
    cannot :manage, Subject
    cannot :manage, User

    cannot :manage, :admin_dashboard
    cannot :manage, :students_dashboard
    cannot :manage, :teachers_dashboard

    cannot :manage, :admin_users
    cannot :manage, :teachers_users

    cannot :manage, :representatives_classrooms

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
      can :manage, Post,      user_id: user.id
      can :manage, Subject,   institution_id: user.institution_id
      can :manage, User,      institution_id: user.institution_id

      can :manage, :teachers_dashboard
      can :manage, :teachers_users

      cannot :destroy, User, id: user.id
    end

    if user.teacher?
      can :update, Classroom, teacher_id: user.id

      can :create, Post
      can :manage, Post, user_id: user.id

      can :manage, :teachers_dashboard
    end

    if user.coordinator?
      can :manage, Classroom, course_id: user.coordinated_courses_ids
      can :manage, Subject,   course_id: user.coordinated_courses_ids
    end

    if user.student?
      can :create, Post
      can :manage, Post, user_id: user.id

      can :manage, :students_dashboard
    end

    if user.representative?
      can :members, Classroom, id: user.represented_classrooms_ids
      can :manage, :representatives_classrooms
    end
  end
end
