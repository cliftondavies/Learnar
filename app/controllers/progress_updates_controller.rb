class ProgressUpdatesController < ApplicationController
  before_action :authenticate_user!

  def index
    @community_progress_updates = ProgressUpdate.include_author.most_recent
    @progress_update = ProgressUpdate.new
    @users_to_follow = User.users_to_follow(current_user)
  end

  def create
    @progress_update = current_user.progress_updates.build(progress_update_params)

    if @progress_update.save
      redirect_back fallback_location: progress_updates_path, notice: 'Progress update was successful.'
    else
      render :index, alert: 'Progress update was not successful. Please try again'
    end
  end

  private

  def progress_update_params
    params.require(:progress_update).permit(:text)
  end
end
