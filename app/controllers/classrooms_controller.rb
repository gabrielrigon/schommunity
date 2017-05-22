class ClassroomsController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource

  # ---- actions ----

  def forum
    @posts = resource.posts.order('created_at desc')
  end
end
