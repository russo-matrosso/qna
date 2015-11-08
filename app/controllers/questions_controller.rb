class QuestionsController < ApplicationController
  before_action :load_question, only: [:show, :edit, :update, :destroy, :add_favourite]
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

  # def favourite
  #   type = params[:type]
  #   if type == 'favourite' && current_user.favourites.exclude?(@question)
  #     current_user.favourites << @question
  #     redirect_to :back, notice: ""
  #   elsif type == 'unfavourite' && current_user.favourites.include?(@question)
  #     current_user.favourites.delete(@question)
  #     redirect_to :back, notice: "You unfavourited #{@question.title}"
  #   else
  #     redirect_to :back, notice: 'Nothing happened.'
  #   end
  # end

  def add_favourite
    current_user.add_favourite(@question)
    redirect_to :back, notice: "You favorited #{@question.title}"
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :type, attachments_attributes: [:file])
  end
end
