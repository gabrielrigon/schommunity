module Teachers::ClassroomsHelper
  def subjects_collection(course_id)
    course_id ? Course.find(course_id).subjects : []
  end

  def students_collection(course_id)
    course_id ? Course.find(course_id).users : []
  end

  def teachers_collection(user)
    User.teachers.where(institution: user.institution)
  end
end
