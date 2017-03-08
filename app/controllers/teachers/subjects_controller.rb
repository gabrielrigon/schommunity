class Teachers::SubjectsController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource

  # ---- breadcrumbs ----

  add_breadcrumb 'Disciplinas', :teachers_subjects_path

  # ---- methods ----

  def index
    respond_to do |format|
      format.html
      format.json { render json: SubjectDatatable.new(view_context) }
    end
  end

  def new
    @subject = Subject.new
    @subject.institution = current_user.institution
    @subject.course_id = current_user.coordinated_course_id if current_user.coordinator?
  end

  private

  def subject_params
    params.require(:subject).permit!
  end

end
