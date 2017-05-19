module Students::DashboardHelper
  def classroom_data(classroom_user)
    if classroom_user.classroom.posts.valid.count > 1 || classroom_user.classroom.posts.valid.count < 1
      post = 'posts'
    else
      post = 'post'
    end

    if classroom_user.classroom.users.count > 1
      "#{classroom_user.classroom.users.count} alunos - #{classroom_user.classroom.posts.valid.count} #{post}"
    else
      "1 aluno - #{classroom_user.classroom.posts.valid.count} #{post}"
    end
  end
end
