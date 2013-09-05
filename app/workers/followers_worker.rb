class FollowersWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_id)
    cursor = "-1"
    current_user = User.find(user_id)
    until cursor == "0"
      follower_info = current_user.twitter.followers(cursor: cursor).attrs
      follower_info[:users].each do |follower|
        unless Follower.find_by(fid: follower[:id_str])
          current_user.followers.build(
            fid: follower[:id_str],
            name: follower[:screen_name]
          )
        end
      end
      cursor = follower_info[:next_cursor_str]
    end
    current_user.save
  end

end