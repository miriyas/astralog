class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
	
  # admin
  def require_admin
    unless admin_logged_in?
      redirect_to admin_login_path
    end
  end
	
  def admin_logged_in?
    current_user && current_user.admin?
  end

end
