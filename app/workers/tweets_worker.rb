class TweetsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(follower_id)
    one_week_ago = 1.week.ago.time.to_s.split.first
    follower = Follower.find(follower_id)
    max_tweet_id = follower.tweets.map {|tweet| tweet.tid }.max.to_i || 1
    Twitter.search("from:#{follower.name}", since: one_week_ago, count: 50,
                   since_id: max_tweet_id).attrs[:statuses].each do |status|
      follower.tweets.build(
        tid: status[:id_str],
        content: status[:text]
      )
    end
    follower.save
  end

end