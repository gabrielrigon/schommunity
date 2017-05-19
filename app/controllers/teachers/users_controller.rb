class Teachers::UsersController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource

  # ---- breadcrumbs ----

  add_breadcrumb 'Usuários', :teachers_users_path

  # ---- actions ----

  def index
    respond_to do |format|
      format.html
      format.json { render json: Teachers::UserDatatable.new(view_context) }
    end
  end

  def new
    @user = User.new
    @user.build_address
    @user.build_student
  end

  def create
    resource.institution = current_user.institution
    create!
  end

  def edit
    resource.build_address if resource.address.blank?
  end

  def search
    respond_to do |format|
      format.json do
        users = User.where(institution_id: current_user.institution_id)
                    .search(params[:q])
        render json: users.to_json
      end
    end
  end

  def resend_invitation
    user = User.find params[:id]
    user.invite!

    redirect_to collection_path, notice: 'Convite reenviado'
  end

  # ---- methods ----

  private

  def user_params
    if request.patch?
      params.require(:user).permit!.except(:cpf)
    else
      params.require(:user).permit!
    end
  end
end
