require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:question) {create :question}
  let(:user) {create :user}
  sign_in_user

  describe 'POST #create' do

    context 'with valid attributes' do
      it 'should save the answer to the database' do
        expect {post :create,
                     answer: attributes_for(:answer),
                     question_id: question,
                     format: :json
        }.to change(question.answers, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'should not save the answer in database' do
        expect {post :create,
                     answer: attributes_for(:invalid_answer),
                     question_id: question,
                     format: :json
        }.not_to change(Answer, :count)
      end
    end
  end

  describe 'PATCH #update' do
    let(:answer) {create(:answer, user_id: user, question_id: question)}

    it 'should assign the requested answer to @answer' do
      patch :update,
            answer: attributes_for(:answer),
            question_id: question,
            id: answer,
            format: :json
      expect(assigns(:answer)).to eq answer
    end

    it 'should change the answer' do
      patch :update,
             answer: {body: 'new body'},
             question_id: question,
             id: answer,
             format: :json
      answer.reload
      expect(answer.body).to eq 'new body'
    end
  end

  describe 'DELETE #destroy' do
    let(:answer) {create(:answer, user_id: user, question_id: question)}

    it 'should assign the requested answer to @answer' do
      delete :destroy,
            question_id: question,
            id: answer,
            format: :json
      expect(assigns(:answer)).to eq answer
    end

    it 'should delete the answer from the database' do
      answer
      expect{delete :destroy,
                    question_id: question,
                    id: answer,
                    format: :json}.to change(Answer, :count).by(-1)
    end

  end
end
