module Teachers::SubjectsHelper
  def courses_collection(user)
    courses = Course.where { institution.eq user.institution }

    if user.schoolmaster?
      courses
    elsif user.coordinator?
      courses.where { id.in user.coordinated_courses_ids }
    end
  end
end
