class TweetsController < ApplicationController

  def new
    @followers = {}
    current_user.followers.each do |follower|
      @followers[follower.id] = follower.name
    end
    @followers.each do |id, name|
      Twitter.user_timeline(name).each do |status|
        Tweet.find_or_create_by_tid(
          tid: status.id,
          content: status.full_text,
          follower_id: id
        )
      end
    end

  end

end
