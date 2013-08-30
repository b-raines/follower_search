class TrendsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(follower_id, max_tweet_id)
    follower = Follower.find(follower_id)
    Twitter.user_timeline(follower.name, since_id: max_tweet_id).each do |status|
      follower.tweets.build(
        tid: status.id.to_s,
        content: status.full_text
      )
    end
    follower.save
  end

end