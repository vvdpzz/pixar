class AnswersController < ApplicationController
  def create
    answer = current_user.answers.build(params[:answer])
    if answer.save
      render json: answer.as_json, status: :ok
    else
      render json: answer.errors, status: :unprocessable_entity
    end
  end
end
