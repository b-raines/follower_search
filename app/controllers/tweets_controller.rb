class TweetsController < ApplicationController

  before_action :get_followers

  def new
    
    @followers.each do |id, name|
      current_tweets = Follower.find(id).tweets
      tweet_ids = Array.new(2, "1")
      current_tweets.each do |tweet|
        tweet_ids << tweet.tid
      end
      Twitter.user_timeline(name, since_id: tweet_ids.max).each do |status|
        Tweet.find_or_create_by_tid(
          tid: status.id,
          content: status.full_text,
          follower_id: id
        )
      end
    end

  end

  def get_followers
    @followers = {}
    current_user.followers.each do |follower|
      @followers[follower.id] = follower.name
    end
  end

end
