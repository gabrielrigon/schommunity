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

  def forum
    if request.patch?
      @comment = Comment.new
      @comment.post = resource
      @comment.user = current_user
      @comment.content = params[:comment][:content]

      if @comment.save
        redirect_to forum_post_path(resource),
                    notice: 'Comentário inserido com sucesso'
      else
        redirect_to forum_post_path(resource),
                    alert: 'O comentário não pode ser inserido'
      end
    else
      @comments = resource.comments
    end
  end

  # ---- methods ----

  private

  def post_params
    params.require(:post).permit!
  end
end
