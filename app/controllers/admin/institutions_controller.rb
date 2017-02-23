class Admin::InstitutionsController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!

  # ---- breadcrumbs ----

  add_breadcrumb 'Instituições', :admin_institutions_path

  # ---- methods ----

  def index
    respond_to do |format|
      format.html
      format.json { render json: InstitutionDatatable.new(view_context) }
    end
  end
end
