class TweetsController < ApplicationController

  before_action :delete_old_tweets

  def create
    current_user.followers.each do |follower|
      max_tweet_id = follower.tweets.map {|tweet| tweet.tid }.max || '1'
      if max_tweet_id > '1'
        Twitter.search(follower.name, since_id: max_tweet_id).attrs[:statuses].each do |status|
          follower.tweets.build(
            tid: status[:id_str],
            content: status[:text]
          )
        end
      else
        Twitter.user_timeline(follower.name).each do |status|
          follower.tweets.build(
            tid: status.id.to_s,
            content: status.full_text
          )
        end
      end
      follower.save
    end
    redirect_to action: 'static_pages#home'
  end

  def delete_old_tweets
    Tweet.where("created_at < ?", 7.days.ago).delete_all
  end

end