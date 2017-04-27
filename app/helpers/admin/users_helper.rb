module Admin::UsersHelper
  def coordinators_collection(institution_id)
    User.valid.where { (:user_type_id.in Constantine.invoke(UserType, :teacher)) & (:institution_id.eq institution_id) }
  end

  def display_student_number_container(resource)
    resource.new_record? || resource.student? ? 'block' : 'none'
  end

  def user_type_collection
    UserType.where.not(alias: 'admin')
  end
end
