class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?
  helper_method :admin?
  before_action :require_login

  def logged_in?
    session[:user_id]
  end

  def require_login
    unless current_user
      redirect_to login_path, alert: 'You need to be logged in to view this page!'
    end
  end

  def admin?
    current_user && current_user.admin?
  end

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end


end
