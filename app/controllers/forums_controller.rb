class ForumsController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource class: :forum

  # ---- methods ----

  def resource
    @classroom ||= Classroom.find(params[:id].to_i)
  end
end
