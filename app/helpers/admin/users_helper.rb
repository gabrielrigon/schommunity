module Admin::UsersHelper
  def coordinators_collection(institution_id)
    User.valid.where { (:user_type_id.in Constantine.invoke(UserType, :teacher)) & (:institution_id.eq institution_id) }
  end

  def display_student_data_container(resource)
    resource.new_record? || resource.student? ? 'block' : 'none'
  end

  def user_type_collection(user)
    if user.admin?
      UserType.where(alias: 'schoolmaster')
    else
      UserType.where.not(alias: 'admin')
    end
  end

  def institution_courses_collection(user)
    Course.where(institution_id: user.institution_id)
  end
end
