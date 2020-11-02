# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?
  helper_method :admin?

  before_action :require_login

  def logged_in?
    current_user.present?
  end

  def require_logout
    redirect_to root_url if logged_in?
  end

  def require_login
    redirect_to login_path, alert: 'You need to be logged in to view this page!' unless logged_in?
  end

  def require_admin
    redirect_to request.referrer || root_path, alert: 'You do not have permission for this action' unless admin?
  end

  def admin?
    current_user&.admin?
  end

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end
end
