require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) {create(:user)}
  before(:each) {sign_in user}

  describe 'POST #create' do
    let(:question) {create(:question)}
    let(:answer) {create(:answer, user_id: user, question_id: question)}

    it  'loads question if parent is question' do
      post :create, comment: attributes_for(:comment), question_id: question, format: :json
      expect(assigns(:parent)).to eq question
    end

    it  'loads answer if parent is answer' do
      post :create, comment: attributes_for(:comment), answer_id: answer, format: :json
      expect(assigns(:parent)).to eq answer
    end
  end
end
