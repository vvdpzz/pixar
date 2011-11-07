class QuestionsController < ApplicationController
  before_filter :vote_init, :only => [:vote_for, :vote_against]
  
  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.json
  def create
    params[:question][:credit] = params[:question][:user_credit] if params[:question][:user_credit].to_i > 0
    params[:question].delete(:user_credit)
    
    if params[:question][:user_reputation].to_i > 0
      params[:question][:reputation] = params[:question][:user_reputation]
    end
    params[:question].delete(:user_reputation)
    
    @question = current_user.questions.build(params[:question])

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.json
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render json: @question, status: :ok, location: @question }
      else
        format.html { render action: "edit" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :ok }
    end
  end
  
  def answers
    question = Question.find params[:id]
    render json: question.answers.collect{|answer| answer.as_json}, status: :ok
  end
  
  # TODO vvdpzz will do vote day limit
  # PUT /questions/:id/vote_for
  def vote_for
    if current_user.credit >= Settings.vote_for_limit and @voted != true
      if @voted == nil
        if current_user.vote_for @question
          render json: {:id => @question.id, :votes_count => @question.plusminus}, status: :ok
        end
      else
        if current_user.vote_exclusively_against @question
          render json: {:id => @question.id, :votes_count => @question.plusminus}, status: :ok
        end
      end
    end
  end
  
  # PUT /questions/:id/vote_against
  def vote_against
    if current_user.reputation >= Settings.vote_against_limit and @voted != false
      if @voted == nil
        if current_user.vote_against @question
          render json: {:id => @question.id, :votes_count => @question.plusminus}, status: :ok
        end
      else
        if current_user.vote_exclusively_for @question
          render json: {:id => @question.id, :votes_count => @question.plusminus}, status: :ok
        end
      end
    end
  end
  
  # PUT /questions/:id/category_add/:category_name
  def category_add
      category_id = Category.find params[:category_name]
      question_id = params[:id]
      strong_inert = ActiveRecord::Base.connection.execute("INSERT INTO category_questions SET category_id=#{category_id},question_id=#{question_id}")
#      category_question = CategoryQuestion.new (:category_id=>category_id,:question_id=>question_id)
#      category_question = CategoryQuestion.new ( :category_id=>1, :question_id=>2932718821909611 )
      respond_to do |format|
        #if category_question.save
        if strong_inert
          format.json { head :ok }
        else
          format.json { render json: strong_inert.errors, status: :unprocessable_entity }
        end
      end
  end
  
  # PUT /questions/:id/category_del/:category_name
  def category_del
    category_id   = Category.find params[:category_name]
    question_id   = params[:id]
    strong_delete  = ActiveRecord::Base.connection.execute("DELETE category_questions WHERE category_id=#{category_id} and question_id=#{question_id}")
    respond_to do |format|
      if strong_inert
        format.json { head :ok }
      else
        format.json { render json: strong_delete.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def tag_add
  
  end
  
  def tag_del
    
  end
  
  protected
    def vote_init
      @question = Question.select("id").find_by_id(params[:id])
      @voted = @question.trivalent_voted_by? current_user
    end
end
