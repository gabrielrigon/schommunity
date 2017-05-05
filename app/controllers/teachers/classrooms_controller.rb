class Teachers::ClassroomsController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource

  # ---- breadcrumbs ----

  add_breadcrumb 'Salas', :teachers_classrooms_path

  # ---- actions ----

  def index
    respond_to do |format|
      format.html
      format.json { render json: Teachers::ClassroomDatatable.new(view_context) }
    end
  end

  def create
    resource.institution = current_user.institution
    create!
  end

  def members
    if request.patch?
      if resource.update_attributes(classroom_params)
        redirect_to members_teachers_classroom_path(resource),
                    notice: 'Os membros foram atualizados com sucesso'
      else
        redirect_to members_teachers_classroom_path(resource),
                    alert: 'Existem alunos duplicados, nada foi alterado'
      end
    end
  end

  # ---- methods ----

  def subject_field
    @subjects = Course.find(params[:course_id]).subjects
    render layout: false
  end

  def representative_field
    @representatives = Course.find(params[:course_id]).users
    render layout: false
  end

  def substitute_representative_field
    @substitute_representatives = Course.find(params[:course_id]).users
    render layout: false
  end

  private

  def classroom_params
    if request.patch?
      params.require(:classroom)
            .permit(:teacher_id, :helper_id, :representative_id, :substitute_representative_id,
                    classroom_users_attributes: [:id, :user_id, :_destroy])
    else
      params.require(:classroom).permit!
    end
  end
end
