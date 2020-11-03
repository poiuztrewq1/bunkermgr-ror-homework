class AssignmentsController < ApplicationController
  before_action :require_admin

  def assign_user
    @bunker = Bunker.find(params[:bunker_id])
    redirect_to @bunker, alert: 'Bunker already full' and return if @bunker.full?

    users   = @bunker.user_ids
    @users  = users.any? ? User.where('id not in (?)', users).pluck(:name, :id) : User.all.pluck(:name, :id)
    redirect_to @bunker, alert: "All possible users are assigned to #{@bunker.name}" if @users.empty?
  end

  def assign_bunker
    @user    = User.find(params[:user_id])
    bunkers  = @user.bunker_ids
    @bunkers = if bunkers.any?
                 Bunker.where('id not in (?)', bunkers).all.filter { |b| !b.full? }.map { |b| [b.name, b.id] }
               else
                 Bunker.all.pluck(:name, :id)
               end
    redirect_to @user, alert: "#{@user.name} is already assigned to all possible bunkers" if @bunkers.empty?
  end

  def assign
    user   = User.find(params[:user_id])
    bunker = Bunker.find(params[:bunker_id])
    bunker.users << user
    redirect_to root_path, notice: 'Assignment successful'
  end

  def destroy
    user   = User.find(params[:user_id])
    bunker = Bunker.find(params[:bunker_id])
    bunker.users.delete(user)
    redirect_to root_path, notice: 'Assignment successfully deleted'
  end
end
