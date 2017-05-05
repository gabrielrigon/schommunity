module PostsHelper
  def classrooms_collection(user)
    if user.student?
      user.classrooms.map { |classroom| ["#{classroom.uuid} - #{classroom.subject_name}", classroom.id] }
    elsif user.schoolmaster?
      Classroom.where(institution_id: user.institution_id)
               .map { |classroom| ["#{classroom.uuid} - #{classroom.subject_name}", classroom.id] }
    else
      Classroom.where("teacher_id = #{user.id} or helper_id = #{user.id}")
               .map { |classroom| ["#{classroom.uuid} - #{classroom.subject_name}", classroom.id] }
    end
  end
end
