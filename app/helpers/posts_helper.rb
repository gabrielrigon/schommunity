module PostsHelper
  def classrooms_collection(user)
    user.classrooms.map { |classroom| ["#{classroom.uuid} - #{classroom.subject_name}", classroom.id] }
  end
end
