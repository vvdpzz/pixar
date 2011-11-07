class AutosaveController < ApplicationController
  def save_question
    id = params[:id].to_i
    hash = {title: params[:title], content: params[:content]}
    id = UUIDList.pop if id == 0
    $redis.hset "users:#{current_user.id}.save_question", id, MultiJson.encode(hash)
    render json: {id: id}, status: :ok
  end
  
  def discard_question
    $redis.hdel "users:#{current_user.id}.save_question", params[:id]
    render nothing: true
  end
  
  def save_answer
    id, content = params[:id], params[:content]
    $redis.hset "users:#{current_user.id}.save_answer", id, content
    render json: {id: id}, status: :ok
  end
  
  def discard_answer
    $redis.hdel "users:#{current_user.id}.save_answer", params[:id]
    render nothing: true
  end
end
