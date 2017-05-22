class ClassroomsController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource

  # ---- actions ----

  def forum
    @posts = resource.posts
                     .paginate(page: params[:page], per_page: 5)
                     .order('created_at desc')
  end
end
