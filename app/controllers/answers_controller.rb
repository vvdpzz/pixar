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
    
    question_info = Question.select('credit,reputation,correct_answer_id').find_by_id(question_id)
    if question_info.correct_answer_id == 0
      winner_id = Answer.select('user_id').find_by_id(answer_id)
      reputation_for_winner,reputation_for_asker = question_info.reputation + Settings.answer_accept, Settings.question_accept_answer
      transaction_from_system_for_winner, transaction_from_system_for_asker = Settings.t_answer_accept, Settings.t_question_accept_answer
      if winner_id != current_user.id
        Answer.strong_accept_answer(question_id,answer_id,asker_id,winner_id,reputation_for_winner,reputation_for_asker,question_info.credit,transaction_from_system_for_winner,transaction_from_system_for_asker)
        respond_to do |format|
            render status: :ok
        end
      end
    end
  end

end
