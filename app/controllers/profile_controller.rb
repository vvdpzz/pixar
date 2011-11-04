class ProfileController < ApplicationController
  include ActionView::Helpers::DateHelper
  before_filter :get_current_user_profile, :only => [:update_description, :update_location, :update_introduction, :update_website]
  def follow_user
    user = User.select("id,username,picture").find_by_id(params[:uid])
    if user and user.id != current_user.id
      current_user.follow_user!(user)
      $redis.hset("users:#{current_user.id}.following_users.info", params[:uid], MultiJson.encode(user))
      
      hash = {}
      hash[:created_at] = Time.now
      hash[:type] = "follow"
      hash[:user_id] = current_user.id
      hash[:username] = current_user.username
      $redis.incr("notifications:#{params[:uid]}:unreadcount");
      $redis.lpush("notifications:#{params[:uid]}", MultiJson.encode(hash))
      # hash[:created_at] = time_ago_in_words(Time.now)
      # Pusher["presence-notifications_#{params[:uid]}"].trigger('notification_created', MultiJson.encode(hash))
      
      render json: user
    else
      render json: {msg: "follow faild", rc: 1}
    end 
  end
  
  def unfollow_user
    user = User.select("id").find_by_id(params[:uid])
    if user && current_user.following_user?(user)
      current_user.unfollow_user!(user)
      $redis.hdel("users:#{current_user.id}.following_users.info", params[:uid])
      render json: user
    else
      render json: {msg: "unfollow faild", rc: 1}
    end
  end
  
  def follow_question
    if questin = Question.select("id").find_by_id(params[:cid])
      current_user.follow_question!(questin)
      render json: questin
    else
      render json: {msg: "follow faild", rc: 1}
    end
  end
  
  def unfollow_question
    question = Question.select("id").find_by_id(params[:cid]) 
    if question && current_user.following_quesion(question)
      current_user.unfollow_question!(question)
      render json: question
    else
      render json: {msg: "follow faild", rc: 1}
    end
  end
  
  def update_username
    if current_user.update_attribute(:username, params[:username])
      render json: {result: current_user.username, rc: 0}
    else
      render json: {msg: "update error", rc: 1}
    end
  end
  
  def update_description
    if @profile.update_attribute(:description, params[:description])
      render json: {result: @profile.description, rc: 0}
    else
      render json: {msg: "update error", rc: 1} 
    end   
  end
  
  def update_location
    if @profile.update_attribute(:location, params[:location])
      render json: {result: @profile.location, rc: 0}
    else
      render json: {msg: "update error", rc: 1}   
    end 
  end
   
  def update_introduction
    if @profile.update_attribute(:introduction, params[:introduction])
      render json: {result: @profile.introduction, rc: 0}
    else
      render json: {msg: "update error", rc: 1}   
    end 
  end
  
  def update_website
    website = params[:website].strip
    if website.present? and not website.start_with?("http://")
      website = "http://#{website}"
    end
    if @profile.update_attribute(:website, website)
      render json: {result: @profile.website, rc: 0}
    else
      render json: {msg: "update error", rc: 1}
    end    
  end
  
  def followers
    user = User.find_by_id params[:uid] 
    @users = user.followers if user
    if @users.present?
      render json: @users
    else
      render nothing: true
    end
  end
  
  def following_users
    user = User.find_by_id params[:uid] 
    @users = user.following_users if user
    if @users.present?
      render json: @users
    else
      render nothing: true
    end
  end
  
  def following_questions
    user = User.find_by_id params[:uid]
    questions = user.following_questions if user
    if questions.present?
      render json: questions
    else
      render nothing: true
    end
  end
  
  def photo_upload_response
    current_user.salt = nil
    current_user.picture = params[:Filedata]
    if current_user.save
      render :json => {:picture => current_user.picture.url}
    end
  end
  
  protected
    def get_current_user_profile
      @profile = current_user.profile
    end
end
