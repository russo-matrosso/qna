class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    respond_to do |format|
      if @answer.save
        format.json {render json: @answer, root: false}
      else
        flash = "Answer body can't be blank"
        format.json {render json: flash, status: 406}
      end
    end
  end

  def update
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
    respond_to do |format|
      format.json {render json: @answer, root: false}
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    @answer.destroy
    render nothing: true
  end

  private

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end
end
