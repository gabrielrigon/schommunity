class Admin::UsersController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!

  # ---- breadcrumbs ----

  add_breadcrumb 'Usuários', :admin_users_path


  # ---- methods ----

  def index
    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(view_context) }
    end
  end

  def new
    @user = User.new
    @user.build_address
  end

  private

  def user_params
    params.require(:user).permit!
  end
end
