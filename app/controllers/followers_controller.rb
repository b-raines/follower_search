class FollowersController < ApplicationController

  def create
    follower_info = current_user.twitter.followers.attrs[:users]
    follower_info.each do |follower|
      current_user.followers.build(
        fid: follower[:id_str],
        name: follower[:screen_name]
      )
    end
    current_user.save
    redirect_to action: 'static_pages#home'
  end

end


