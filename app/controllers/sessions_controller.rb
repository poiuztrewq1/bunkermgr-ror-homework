class SessionsController < ApplicationController
  skip_before_action :require_login

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      session[:user_id] = user.id
      redirect_to root_url, notice: 'You have successfully logged in'
    else
      flash.now[:alert] = 'Your login credentials are invalid'
      render :new
    end

  end

  def destroy
    reset_session
    redirect_to root_path
  end


end
