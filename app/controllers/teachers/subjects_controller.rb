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

  def create
    resource.institution = current_user.institution
    create!
  end

  private

  def subject_params
    params.require(:subject).permit!
  end

end
