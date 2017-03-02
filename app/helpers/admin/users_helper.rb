module Admin::UsersHelper
  def coordinators_collection
    User.valid.where.not(user_type_id: Constantine.invoke(UserType, :student))
  end
end
