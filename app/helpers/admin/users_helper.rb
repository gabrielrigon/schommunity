module Admin::UsersHelper
  def coordinators_collection(institution_id)
    User.valid.where { (:user_type_id.in Constantine.invoke(UserType, :teacher)) & (:institution_id.eq institution_id) }
  end
end
