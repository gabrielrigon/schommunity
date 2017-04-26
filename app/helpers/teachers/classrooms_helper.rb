module Teachers::ClassroomsHelper
  def subjects_collection(course_id)
    course_id ? Course.find(course_id).subjects : []
  end

  def representative_collection(user)
    User.students.where(institution: user.institution)
  end

  def teachers_collection(user)
    User.teachers.where(institution: user.institution)
  end
end
