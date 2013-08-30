class TweetsController < ApplicationController

  before_action :delete_old_tweets

  def create
    current_user.followers.each do |follower|
      #@max_tweet_id = follower.tweets.map {|tweet| tweet.tid }.max || '1'
      @follower = follower
      TrendsWorker.perform_async(@follower.id)
    end
    redirect_to action: 'static_pages#home'
  end

  def delete_old_tweets
    Tweet.where("created_at < ?", 7.days.ago).delete_all
  end

end