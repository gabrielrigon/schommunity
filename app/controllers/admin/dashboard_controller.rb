class Admin::DashboardController < InheritedResources::Base
  layout 'admin'

  before_filter :authenticate_user!

  add_breadcrumb 'Dashboard', :admin_dashboard_index_path

  def index
  end
end
