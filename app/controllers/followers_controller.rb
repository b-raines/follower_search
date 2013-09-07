class FollowersController < ApplicationController

  def create
    FollowersWorker.perform_async(current_user.id)
    flash[:info] = "Requesting information from Twitter."
    redirect_to action: 'static_pages#home'
  end

end


