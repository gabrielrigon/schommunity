class Admin::DashboardController < InheritedResources::Base
  before_filter :authenticate_user!

  add_crumb('Dashboard') { |instance| instance.send :admin_dashboard_index_path }

  def index
  end
end
