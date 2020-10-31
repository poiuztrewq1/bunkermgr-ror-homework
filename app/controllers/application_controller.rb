class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?
  before_action :require_login

  def logged_in?
    session[:user_id]
  end

  def require_login
    unless current_user
      redirect_to login_path
    end
  end

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end


end
