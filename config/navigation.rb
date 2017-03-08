SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |primary|
    primary.dom_class = 'sidebar-menu'

    # ---- types of dashboards ----
    if current_user.admin?
      primary.item :admin_dashboard, menu_label_icon('Dashboard', 'dashboard'), admin_dashboard_index_path, class: 'root-level', highlights_on: %r{/dashboard} if can?(:manage, :admin_dashboard)
    elsif current_user.student?

    else
      primary.item :teachers_dashboard, menu_label_icon('Dashboard', 'dashboard'), teachers_dashboard_index_path, class: 'root-level', highlights_on: %r{/dashboard} if can?(:manage, :teachers_dashboard)
    end

    primary.item :teachers_courses, menu_label_icon('Cursos', 'graduation-cap'), teachers_courses_path, class: 'root-level', highlights_on: %r{/courses} if can?(:manage, Course)
    primary.item :teachers_subjects, menu_label_icon('Disciplinas', 'book'), teachers_subjects_path, class: 'root-level', highlights_on: %r{/subjects} if can?(:manage, Subject)
    primary.item :admin_institutions, menu_label_icon('Instituições', 'university'), admin_institutions_path, class: 'root-level', highlights_on: %r{/institutions} if can?(:manage, Institution)
    primary.item :admin_users, menu_label_icon('Usuários', 'user'), admin_users_path, class: 'root-level', highlights_on: %r{/users} if can?(:manage, User)
  end

  #   # Add an item to the primary navigation. The following params apply:
  #   # key - a symbol which uniquely defines your navigation item in the scope of the primary_navigation
  #   # name - will be displayed in the rendered navigation. This can also be a call to your I18n-framework.
  #   # url - the address that the generated item links to. You can also use url_helpers (named routes, restful routes helper, url_for etc.)
  #   # options - can be used to specify attributes that will be included in the rendered navigation item (e.g. id, class etc.)
  #   #           some special options that can be set:
  #   #           :if - Specifies a proc to call to determine if the item should
  #   #                 be rendered (e.g. <tt>if: -> { current_user.admin? }</tt>). The
  #   #                 proc should evaluate to a true or false value and is evaluated in the context of the view.
  #   #           :unless - Specifies a proc to call to determine if the item should not
  #   #                     be rendered (e.g. <tt>unless: -> { current_user.admin? }</tt>). The
  #   #                     proc should evaluate to a true or false value and is evaluated in the context of the view.
  #   #           :method - Specifies the http-method for the generated link - default is :get.
  #   #           :highlights_on - if autohighlighting is turned off and/or you want to explicitly specify
  #   #                            when the item should be highlighted, you can set a regexp which is matched
  #   #                            against the current URI.  You may also use a proc, or the symbol <tt>:subpath</tt>.
  #   #
  #   primary.item :key_1, 'name', url, options
  #
  #   # Add an item which has a sub navigation (same params, but with block)
  #   primary.item :key_2, 'name', url, options do |sub_nav|
  #     # Add an item to the sub navigation (same params again)
  #     sub_nav.item :key_2_1, 'name', url, options
  #   end
  #
  #   # You can also specify a condition-proc that needs to be fullfilled to display an item.
  #   # Conditions are part of the options. They are evaluated in the context of the views,
  #   # thus you can use all the methods and vars you have available in the views.
  #   primary.item :key_3, 'Admin', url, class: 'special', if: -> { current_user.admin? }
  #   primary.item :key_4, 'Account', url, unless: -> { logged_in? }
  #
  #   # you can also specify html attributes to attach to this particular level
  #   # works for all levels of the menu
  #   #primary.dom_attributes = {id: 'menu-id', class: 'menu-class'}
  #
  #   # You can turn off auto highlighting for a specific level
  #   #primary.auto_highlight = false
end
