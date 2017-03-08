require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # ---- methods ----

  def go_home
    if user_signed_in?
      if current_user.admin?
        redirect_to admin_dashboard_index_path
      elsif current_user.schoolmaster?
        redirect_to teachers_courses_path
      else
        redirect_to teachers_subjects_path
      end
    else
      redirect_to new_user_session_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:institution_id, :cpf, :email])
  end
end
