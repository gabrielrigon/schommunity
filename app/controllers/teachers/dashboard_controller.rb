class Teachers::DashboardController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource class: :teachers_dashboard

  # ---- breadcrumbs ----

  add_breadcrumb 'Dashboard', :teachers_dashboard_index_path

  # ---- methods ----

  def index
  end
end
