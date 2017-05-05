class PostsController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource

  # ---- breadcrumbs ----

  add_breadcrumb 'Posts', :posts_path

  # ---- actions ----

  def index
    respond_to do |format|
      format.html
      format.json { render json: PostDatatable.new(view_context) }
    end
  end

  def create
    resource.institution = current_user.institution
    resource.user = current_user
    create!
  end

  # ---- methods ----

  private

  def post_params
    params.require(:post).permit!
  end
end
