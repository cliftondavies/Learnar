class FollowingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @following = current_user.outgoings.build(followed_id: params[:user_id])
    if @following.save
      redirect_back fallback_location: user_path(current_user),
                    notice: "You are now following #{@following.followed.name}!"
    else
      flash.now[:alert] = 'Follow was unsuccessful. Please try again'
      render 'users/show'
    end
  end

  def destroy
    @following = Following.find(params[:id])
    @following.destroy
    redirect_back fallback_location: user_path(current_user), notice: "You unfollowed #{@following.followed.name}!"
  end
end
