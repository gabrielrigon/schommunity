class Teachers::UsersController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource class: :teachers_users

  # ---- breadcrumbs ----

  add_breadcrumb 'Usuários', :teachers_users_path

  # ---- methods ----

  def index
    respond_to do |format|
      format.html
      format.json { render json: Teachers::UserDatatable.new(view_context) }
    end
  end

  def new
    @user = User.new
    @user.build_address
    @user.institution = current_user.institution
  end

  def edit
    resource.build_address if resource.address.blank?
  end

  private

  def user_params
    params.require(:user).permit!
  end
end
