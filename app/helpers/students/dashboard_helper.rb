module Students::DashboardHelper
  def classroom_data(classroom)
    if classroom.posts.valid.count > 1 || classroom.posts.valid.count < 1
      post = 'posts'
    else
      post = 'post'
    end

    if classroom.users.count > 1
      "#{classroom.users.count} alunos - #{classroom.posts.valid.count} #{post}"
    else
      "1 aluno - #{classroom.posts.valid.count} #{post}"
    end
  end
end
