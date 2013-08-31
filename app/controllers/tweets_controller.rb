class TweetsController < ApplicationController

  before_action :delete_old_tweets

  def create
    current_user.followers.each do |follower|
      @follower = follower
      TweetsWorker.perform_async(@follower.id)
    end
    redirect_to action: 'static_pages#home'
  end

  def delete_old_tweets
    Tweet.where("created_at < ?", 1.week.ago).delete_all
  end

end