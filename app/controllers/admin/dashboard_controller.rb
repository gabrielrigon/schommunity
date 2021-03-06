class Admin::DashboardController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource class: :admin_dashboard

  # ---- breadcrumbs ----

  add_breadcrumb 'Dashboard', :admin_dashboard_index_path

  # ---- actions ----

  def index
    @registered_users = User.valid.count
    @registered_institutions = Institution.valid.count
  end
end
