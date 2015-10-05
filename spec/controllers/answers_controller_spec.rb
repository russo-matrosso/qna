require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'POST #create' do
    let(:question) {create :question}
    let(:user) {create :user}
    sign_in_user

    context 'with valid attributes' do
      it 'should save the answer to the database' do
        expect {post :create,
                     answer: attributes_for(:answer),
                     question_id: question
        }.to change(question.answers, :count).by(1)
      end
      it 'redirects to question' do
        post :create, answer: attributes_for(:answer), question_id: question
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid attributes' do
      it 'should not save the answer in database' do
        expect {post :create,
                     answer: attributes_for(:invalid_answer),
                     question_id: question
        }.not_to change(Answer, :count)
      end
      it 'redirects to question' do
        post :create, answer: attributes_for(:invalid_answer), question_id: question
        expect(response).to redirect_to question_path(question)
      end
    end
  end
end
