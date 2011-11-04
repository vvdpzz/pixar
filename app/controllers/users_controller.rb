class UsersController < ApplicationController
  def show
    if user = User.select("id,name,avatar, about_me").find_by_id(params[:id], :include => :profile)
      # follower_users = $redis.scard("users:#{@user.id}.follower_users")
      # following_users = $redis.scard("users:#{@user.id}.following_users")
      # following_contests = $redis.scard("users:#{@user.id}.following_contests")
      # is_myself = (@user.id == current_user.id)
      
      render json: {:user => user}
    else
      
    end
  end
end