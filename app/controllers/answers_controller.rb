class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_answer, except: :create


  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params.merge(user_id: current_user.id))
    respond_to do |format|
      if @answer.save
        format.json {render_without_remotipart json: @answer, root: false}
      else
        flash = "Answer body can't be blank"
        format.json {render json: flash, status: 406}
      end
    end
  end

  def update
    @answer.update(answer_params)
    respond_to do |format|
      format.json {render json: @answer, root: false}
    end
  end

  def destroy
    @answer.destroy
    render nothing: true
  end

  private

  def load_answer
    @answer = Answer.find(params[:id])

  end

  def load_question
    @question = Question.find(params[:question_id]) 
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end
end
