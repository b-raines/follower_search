class FollowersController < ApplicationController

  def new
    followers = current_user.twitter.followers.attrs[:users]
    followers.each do |f|
      follower = Follower.create(
        fid: f[:id_str],
        name: f[:screen_name],
      )
      follower.update_attributes(
        user_id: current_user.id
      )
    end
    redirect_to new_tweet_path
  end

  def index
    @followers = []
    current_user.followers.each do |follower|
      @followers << follower.name
    end
  end

end

