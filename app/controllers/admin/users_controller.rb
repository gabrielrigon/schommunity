class Admin::UsersController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource

  # ---- breadcrumbs ----

  add_breadcrumb 'Usuários', :admin_users_path

  # ---- methods ----

  def index
    respond_to do |format|
      format.html
      format.json { render json: Admin::UserDatatable.new(view_context) }
    end
  end

  def new
    @user = User.new
    @user.build_address
    @user.build_student
  end

  def edit
    resource.build_address if resource.address.blank?
  end

  private

  def user_params
    params.require(:user).permit!
  end
end
