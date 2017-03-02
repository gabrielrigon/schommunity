class Teachers::CoursesController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!

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
    @course = Course.new course_params
    @course.institution = current_user.institution
    @course.save
  end

  private

  def course_params
    params.require(:course).permit!
  end
end