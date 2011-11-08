class AnswersController < ApplicationController
  def create
    answer = current_user.answers.build(params[:answer])
    if answer.save
      render json: answer.as_json, status: :ok
    else
      render json: answer.errors, status: :unprocessable_entity
    end
  end
  
  # PUT /questions/:question_id/answers/:id/accept
  def accept
    # 1 User: add credit and/or money to user table
    # 2 CreditTransaction and/or MoneyTransaction
    # 3 Question: mark correct answer
    # 4 Answer: mark is correct answer
    
    #:payment => false,
    #:trade_type => TradeType::ACCEPT,
    #:trade_status => TradeStatus::SUCCESS

    question_id,answer_id,user_id = params[:question_id], params[:id], current_user.id
    question_info = Question.select('user_id,credit,money,correct_answer_id').where(:id => question_id)
    credit,money = question_info.credit,question_info.money
    if question_info.user_id != current_user.id and question_info.correct_answer_id == 0
      Question.strong_accept_answer(question_id, answer_id, user_id, credit, money)
      question.async_accept_answer(answer.id)
      # Notification.notif_answer_accepted (question_id, answer_id)
      respond_to do |format|
        format.json { head :ok }
      end
    end
  end
end
