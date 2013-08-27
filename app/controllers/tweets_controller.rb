class TweetsController < ApplicationController

  before_action :get_followers

  def new
    
    @followers.each do |id, name|
      current_tweets = Follower.find(id).tweets
      tweet_ids = Array.new(2, "1")
      current_tweets.each do |tweet|
        tweet_ids << tweet.tid
      end
      max_id = tweet_ids.max
      Twitter.user_timeline(name, since_id: max_id).each do |status|
        Tweet.create(
          tid: status.id.to_s,
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
