class Teachers::CoursesController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource

  # ---- breadcrumbs ----

  add_breadcrumb 'Cursos', :teachers_courses_path

  # ---- methods ----

  def index
    respond_to do |format|
      format.html
      format.json { render json: CourseDatatable.new(view_context) }
    end
  end

  def create
    resource.institution = current_user.institution
    create!
  end

  private

  def course_params
    params.require(:course).permit!
  end
end
