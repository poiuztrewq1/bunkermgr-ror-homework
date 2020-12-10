class AssignmentsController < ApplicationController
  before_action :require_admin

  def assign_user
    @bunker = Bunker.find(params[:bunker_id])
    redirect_to @bunker, alert: 'Bunker already full' and return if @bunker.full?

    assigned_users = @bunker.user_ids
    @users         = (assigned_users.any? ? User.where('id not in (?)', assigned_users).all : User.all).pluck(:name, :id)
    redirect_to @bunker, alert: "All possible users are assigned to #{@bunker.name}" if @users.empty?
    session[:assign_redirect_url] = bunker_path @bunker
  end

  def assign_bunker
    @user            = User.find(params[:user_id])
    assigned_bunkers = @user.bunker_ids
    @bunkers         = (assigned_bunkers.any? ? Bunker.where('id not in (?)', assigned_bunkers).all : Bunker.all)
                         .filter { |b| !b.full? }.map { |b| [b.name, b.id] }
    redirect_to @user, alert: "#{@user.name} is already assigned to all possible bunkers" if @bunkers.empty?
    session[:assign_redirect_url] = user_path @user
  end

  def assign
    user   = User.find(params[:user_id])
    bunker = Bunker.find(params[:bunker_id])
    bunker.users << user
    redirect_to session[:assign_redirect_url] || root_path, notice: 'Assignment successful'
  end

  def destroy
    user   = User.find(params[:user_id])
    bunker = Bunker.find(params[:bunker_id])
    bunker.users.delete(user)
    redirect_to request.referer || root_path, notice: 'Assignment successfully deleted'
  end
end
