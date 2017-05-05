class Representatives::ClassroomsController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource class: :representatives_classrooms

  # ---- breadcrumbs ----

  add_breadcrumb 'Salas', :representatives_classrooms_path

  # ---- actions ----

  def index
    respond_to do |format|
      format.html
      format.json { render json: Representatives::ClassroomDatatable.new(view_context) }
    end
  end

  def members
    if request.patch?
      if resource.update_attributes(classroom_params)
        redirect_to members_representatives_classroom_path(resource),
                    notice: 'Os membros foram atualizados com sucesso'
      else
        redirect_to members_representatives_classroom_path(resource),
                    alert: 'Existem alunos duplicados, nada foi alterado'
      end
    end
  end

  # ---- methods ----

  private

  def classroom_params
      params.require(:classroom)
            .permit(classroom_users_attributes: [:id, :user_id, :_destroy])
  end
end
