module Teachers::SubjectsHelper
  def courses_collection(user)
    Course.where { institution.eq user.institution }
  end
end
