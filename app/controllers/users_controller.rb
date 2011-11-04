class UsersController < ApplicationController
  def show
    if user = User.select("id,name,avatar, about_me").find_by_id(params[:id])
      render json: user.as_json(:methods => [:followers_count, :following_users_count, :following_questions_count]).merge(user.profile.as_json)
    end
  end
end
