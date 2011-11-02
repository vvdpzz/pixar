class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(pixar_id: params[:id], content: params[:content])
    if comment.save
      render json: comment, status: :ok
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end
end
