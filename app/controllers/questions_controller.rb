class QuestionsController < ApplicationController
  before_action :load_question, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]

  respond_to :html, :json

  def index
    respond_with(@questions = Question.all)
  end

  def show
    @answers = @question.answers.all
    @answer = @question.answers.build
    @answer.attachments.build
    respond_with @question
    # respond_to do |format|
    #     format.html
    #     format.json {render json: @question.answers.order(created_at: :desc), root: false}
    # end
  end

  def new
    @question = current_user.questions.new
    @question.attachments.build
    respond_with @question
  end

  def edit

  end

  def create
    respond_with(@question = current_user.questions.create(question_params))
  end

  def update
    @question.update(question_params)
    respond_with @question
  end

  def destroy
    respond_with(@question.destroy)
  end

  def add_favourite
    current_user.add_favourite(@question)
    redirect_to :back, notice: "You favorited #{@question.title}"
  end

  def remove_favourite
    current_user.remove_favourite(@question)
    redirect_to :back, notice: "#{@question.title} has been removed from favourites"
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :type, attachments_attributes: [:file])
  end
end
