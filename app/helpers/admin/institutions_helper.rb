module Admin::InstitutionsHelper
  def institutions_collection
    Institution.valid
  end
end
