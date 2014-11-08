class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Exception do |exception|
    if exception.is_a?(CanCan::AccessDenied)
      if current_user
        redirect_to dashboard_path, alert: exception.message
      else
        redirect_to user_omniauth_authorize_path(:twitter)
      end
    elsif Rails.env.production?
      ExceptionMailer.exception_email(exception, current_user).deliver
      render template: false, file: 'public/500.html', status: 500
    else
      raise exception
    end
  end

end
