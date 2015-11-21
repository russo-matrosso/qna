class QuestionsController < ApplicationController
  before_action :load_question, only: [:show, :edit, :update, :destroy, :add_favourite, :remove_favourite, :vote_up, :vote_down]
  before_action :authenticate_user!, except: [:index, :show]

  respond_to :html, :json

  def index
    respond_with(@questions = Question.all)
  end

  def show
    @answers = @question.answers.all
    @answer = @question.answers.build
    @answer.attachments.build
    respond_to do |format|
        format.html
        format.json {render json: @question.answers.order(created_at: :desc), root: false}
    end
  end

  def new
    @question = current_user.questions.new
    @question.attachments.build
  end

  def edit

  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      flash[:notice] = 'Your question has been created'
      redirect_to @question
    else
      render :new
    end
  end

  def update
    @question.update(question_params)
    if @question.save
      flash[:notice] = 'Your question has been successfully updated'
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:notice] = 'Question has been deleted'
    redirect_to questions_path
  end

  def add_favourite
    current_user.add_favourite(@question)
    redirect_to :back, notice: "You favorited #{@question.title}"
  end

  def remove_favourite
    current_user.remove_favourite(@question)
    redirect_to :back, notice: "#{@question.title} has been removed from favourites"
  end

  def vote_up
    current_user.vote_for(@question)
    redirect_to :back, notice: "Voted up #{@question.title}"
  end

  def vote_down
    current_user.vote_down_for(@question)
    redirect_to :back, notice: "Unvoted #{@question.title}"
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :type, attachments_attributes: [:file])
  end
end
