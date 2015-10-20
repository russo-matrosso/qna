class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
      @answer = @question.answers.build(answer_params)
      @answer.user = current_user
    respond_to do |format|
      if @answer.save
        format.json {render json: @answer}
      end
    end
  end

  def update
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
  end

  def destroy
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    @answer.destroy
    render :update
  end

  private

  # def check_author
  #   if current_user != @answer.user
  #     redirect_to root_path
  #   end
  # end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end
end
