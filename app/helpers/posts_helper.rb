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

  def post_type_icon(post)
    if post.post_type_id == Constantine.invoke(PostType, :question)
      'fa fa-question bg-red'
    elsif post.post_type_id == Constantine.invoke(PostType, :information)
      'fa fa-info bg-aqua'
    else
      'fa fa-paperclip bg-yellow'
    end
  end

  def post_comments_count(post)
    if post.comments.count > 1
      "#{post.comments.count} comentários"
    elsif post.comments.count < 1
      'ainda sem comentários'
    else
      '1 comentário'
    end
  end
end
