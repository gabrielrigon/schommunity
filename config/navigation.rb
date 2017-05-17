SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |primary|
    primary.dom_class = 'sidebar-menu'

    # ---- types of dashboards ----
    primary.item :admin_dashboard, menu_label_icon('Dashboard', 'dashboard'), admin_dashboard_index_path, class: 'root-level', highlights_on: %r{/dashboard} if can?(:manage, :admin_dashboard)
    primary.item :students_dashboard, menu_label_icon('Dashboard', 'dashboard'), students_dashboard_index_path, class: 'root-level', highlights_on: %r{/dashboard} if can?(:manage, :students_dashboard)
    primary.item :teachers_dashboard, menu_label_icon('Dashboard', 'dashboard'), teachers_dashboard_index_path, class: 'root-level', highlights_on: %r{/dashboard} if can?(:manage, :teachers_dashboard)

    primary.item :teachers_courses, menu_label_icon('Cursos', 'graduation-cap'), teachers_courses_path, class: 'root-level', highlights_on: %r{/courses} if can?(:manage, Course)
    primary.item :teachers_subjects, menu_label_icon('Disciplinas', 'book'), teachers_subjects_path, class: 'root-level', highlights_on: %r{/subjects} if can?(:manage, Subject)
    primary.item :admin_institutions, menu_label_icon('Instituições', 'university'), admin_institutions_path, class: 'root-level', highlights_on: %r{/institutions} if can?(:manage, Institution)
    primary.item :admin_institutions, menu_label_icon('Mensagens', 'commenting'), chats_path, class: 'root-level', highlights_on: %r{/chats} if can?(:manage, :user_chat)
    primary.item :posts, menu_label_icon('Postagens', 'newspaper-o'), posts_path, class: 'root-level', highlights_on: %r{/posts} if can?(:manage, Post)

    # ---- type of users
    primary.item :teachers_classrooms, menu_label_icon('Salas', 'users'), teachers_classrooms_path, class: 'root-level', highlights_on: %r{/classrooms} if can?(:manage, Classroom)
    primary.item :representatives_classrooms, menu_label_icon('Salas', 'users'), representatives_classrooms_path, class: 'root-level', highlights_on: %r{/classrooms} if can?(:manage, :representatives_classrooms)

    # ---- types of users ----
    primary.item :admin_users, menu_label_icon('Usuários', 'user'), admin_users_path, class: 'root-level', highlights_on: %r{/users} if can?(:manage, :admin_users)
    primary.item :teachers_users, menu_label_icon('Usuários', 'user'), teachers_users_path, class: 'root-level', highlights_on: %r{/users} if can?(:manage, :teachers_users)
  end
end
