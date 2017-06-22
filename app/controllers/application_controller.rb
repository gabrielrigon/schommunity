require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # ---- actions ----

  def go_home
    if user_signed_in?
      if current_user.admin?
        redirect_to admin_dashboard_index_path
      elsif current_user.student?
        redirect_to students_dashboard_index_path
      else
        redirect_to teachers_dashboard_index_path
      end
    else
      redirect_to new_user_session_path
    end
  end

  # ---- cancan ----

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to root_path, alert: 'A página que você tentou acessar não está disponível' }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  # ---- methods ----

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer
      .permit(:sign_up, keys: [:institution_id, :cpf, :email])
  end
end
