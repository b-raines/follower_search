class TweetsController < ApplicationController

  before_action :get_followers
  before_action :clean_up

  def new
    
    @followers.each do |id, name|
      current_tweets = Follower.find(id).tweets
      tweet_ids = Array.new(2, "1")
      current_tweets.each do |tweet|
        tweet_ids << tweet.tid
      end
      max_id = tweet_ids.max
      if max_id > "1"
        statuses = Twitter.search(name, since_id: max_id).attrs[:statuses]
        statuses.each do |status|
          Tweet.create(
            tid: status[:id_str],
            content: status[:text],
            follower_id: id
          )
        end
      else
        Twitter.user_timeline(name).each do |status|
          Tweet.create(
            tid: status.id.to_s,
            content: status.full_text,
            follower_id: id
          )
        end
      end
    end
    redirect_to trends_path
  end

  def get_followers
    @followers = {}
    current_user.followers.each do |follower|
      @followers[follower.id] = follower.name
    end
  end

  def clean_up
    Tweet.where("created_at < ?", 7.days.ago).delete_all
  end

end
