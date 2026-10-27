class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  allow_browser versions: :modern
  stale_when_importmap_changes

  rescue_from CanCan::AccessDenied, with: :handle_access_denied

  protected

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_root_path
    else
      super
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  private

  def handle_access_denied
    redirect_to root_path, alert: "Нет доступа"
  end
end