class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
