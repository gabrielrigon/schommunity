class Admin::InstitutionsController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource

  # ---- breadcrumbs ----

  add_breadcrumb 'Instituições', :admin_institutions_path

  # ---- actions ----

  def index
    respond_to do |format|
      format.html
      format.json { render json: InstitutionDatatable.new(view_context) }
    end
  end

  def new
    @institution = Institution.new
    @institution.build_address
  end

  def edit
    resource.build_address if resource.address.blank?
  end

  # ---- methods ----

  private

  def institution_params
    params.require(:institution).permit!
  end
end
