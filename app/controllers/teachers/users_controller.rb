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
  end

  def create
    resource.institution = current_user.institution
    create!
  end

  def edit
    resource.build_address if resource.address.blank?
  end

  # ---- methods ----

  private

  def user_params
    params.require(:user).permit!
  end
end
