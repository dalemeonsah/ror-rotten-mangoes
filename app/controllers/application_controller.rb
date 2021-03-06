class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def restrict_access
    if !current_user
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end

  def restrict_access_admin
    if !current_user.admin?
      flash[:alert] = "Admins only!"
      redirect_to root_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def previewing?
    session[:admin_id].present?
  end

  def authorize_admin
    current_user.admin? || previewing?
  end

  helper_method :current_user, :previewing?
end
