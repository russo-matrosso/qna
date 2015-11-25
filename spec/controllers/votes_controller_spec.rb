require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  let(:question) {create(:question, id: 1)}
  let!(:answer) {create(:answer, user_id: user, question_id: question)}
  let(:user) {create(:user)}

  before(:each) do |example|
    sign_in user if example.metadata[:sign_in]
    request.env["HTTP_REFERER"] = answer_path(answer) if example.metadata[:redirect_back]
  end


  describe 'POST #vote_up', sign_in: true, redirect_back: true  do
    it 'should assign answer to @parent' do
      post :vote_up, id: answer
      expect(assigns(:parent)).to eq answer
    end

    it 'should vote up answer' do
      expect{post :vote_up, id: answer}.to change(answer.votes, :count).by(1)
    end

    it 'should change votes count by 1' do
      post :vote_up, id: answer
      answer.reload
      expect(answer.votes_sum).to eq 1
    end
  end

  describe 'POST #vote_down', sign_in: true, redirect_back: true  do
    it 'should vote down' do
      expect{post :vote_down, id: answer}.to change(answer.votes, :count).by(1)
    end

    it 'should change votes count by -1' do
      post :vote_down, id: answer
      answer.reload
      expect(answer.votes_sum).to eq -1
    end
  end

  # describe 'DELETE#unvote', sign_in: true, redirect_back: true  do
  #   before do
  #     post :vote_up, id: answer
  #   end

  #   it 'should vote down' do
  #     expect{post :vote_down, id: answer}.to change(answer.votes, :count).by(-1)
  #   end

  #   it 'should change votes count by -1' do
  #     post :vote_down, id: answer
  #     answer.reload
  #     expect(answer.votes_sum).to eq 0
  #   end
  # end
end