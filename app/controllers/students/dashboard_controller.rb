class Students::DashboardController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource class: :students_dashboard

  # ---- breadcrumbs ----

  add_breadcrumb 'Dashboard', :teachers_dashboard_index_path

  # ---- actions ----

  def index
    classrooms_ids = current_user.classroom_users.pluck(:classroom_id)
    @classrooms = Classroom.where { id.in classrooms_ids }
    @posts = Post.valid.where { classroom_id.in classrooms_ids }
                 .order('created_at desc').last(15)
  end
end
