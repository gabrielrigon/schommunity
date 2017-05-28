class Teachers::DashboardController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource class: :teachers_dashboard

  # ---- breadcrumbs ----

  add_breadcrumb 'Dashboard', :teachers_dashboard_index_path

  # ---- actions ----

  def index
    if current_user.teacher?
      classrooms_ids = Classroom.where("teacher_id = #{current_user.id} or helper_id = #{current_user.id}")
                                .ids
      classrooms_ids = classrooms_ids.flatten.uniq
                                     .reject { |item| item.nil? || item == '' }

      @classrooms = Classroom.where(id: classrooms_ids)
      @posts = Post.valid.where { classroom_id.in classrooms_ids }
                   .order('created_at desc').last(15)
    elsif current_user.schoolmaster?
      @registered_users = User.where(institution: current_user.institution)
                              .count
      @classrooms_count = Classroom.where(institution: current_user.institution)
                                   .count
      @posts = Post.valid.where(institution: current_user.institution)
                   .order('created_at desc').last(15)
    end
  end
end
