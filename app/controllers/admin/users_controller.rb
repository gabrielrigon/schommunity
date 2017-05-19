class Admin::UsersController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource

  # ---- breadcrumbs ----

  add_breadcrumb 'Usuários', :admin_users_path

  # ---- actions ----

  def index
    respond_to do |format|
      format.html
      format.json { render json: Admin::UserDatatable.new(view_context) }
    end
  end

  def new
    @user = User.new
    @user.build_address
    # @user.build_student
  end

  def edit
    resource.build_address if resource.address.blank?
  end

  # ---- methods ----

  def student_course_field
    @courses = Institution.find(params[:institution_id]).courses
    render layout: false
  end

  private

  def user_params
    if request.patch?
      params.require(:user).permit!.except(:cpf)
    else
      params.require(:user).permit!
    end
  end
end
