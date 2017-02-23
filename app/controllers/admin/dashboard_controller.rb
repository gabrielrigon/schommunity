class Admin::DashboardController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!

  # ---- breadcrumbs ----

  add_breadcrumb 'Dashboard', :admin_dashboard_index_path

  # ---- methods ----

  def index
  end
end
