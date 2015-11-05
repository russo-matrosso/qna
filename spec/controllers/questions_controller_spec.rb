require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) {create(:question)}

  describe "GET #index" do
    let(:questions) {create_list(:question, 2)}

    before do
      get :index
    end

    it "should populate the array of questions" do
      expect(assigns(:questions)).to match_array(questions)
    end

    it "should render the 'index' view" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before do
      get :show, id: question
    end

    it "should assign the requested question to @question" do
      expect(assigns(:question)).to eq question
    end

    it "should assign new answer to question" do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it "should render a question view" do
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    sign_in_user

    before do
      get :new
    end

    it "should assigns a new question to @question" do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'builds new attachments for question' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end

    it "should render a 'new question' template" do
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    sign_in_user

    before do
      get :edit, id: question
    end

    it "should assign the requested question to @question" do
      expect(assigns(:question)).to eq question
    end

    it "shoult render a 'edit question' template" do
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
    sign_in_user

    context "with valid attributes" do
      it "should save the new question in database" do
        expect {post :create, question: attributes_for(:question)}.to change(Question, :count)
      end

      it "should redirect to show view" do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context "with invalid attributes" do
      it "should not save question in database" do
        expect {post :create, question: attributes_for(:invalid_question)}.not_to change(Question, :count)
      end
      it "should render 'new question' view" do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    sign_in_user

    context "with valid attributes" do
      it "should assign the requested question to question" do
        patch :update, id: question, question: attributes_for(:question)
        expect(assigns(:question)).to eq question
      end

      it "should change question attributes" do
        patch :update, id: question, question: {title: 'new title', body: 'new body'}
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it "should redirect to the updated question" do
        patch :update, id: question, question: attributes_for(:question)
        expect(response).to redirect_to question
      end
    end

    context "with invalid attributes" do
      it "should not change question attributes" do
        patch :update, id: question, question: attributes_for(:invalid_question)
        question.reload
        expect(question.title).to eq attributes_for(:question)[:title]
        expect(question.body).to eq attributes_for(:question)[:body]
      end

      it "should re-render edit view" do
        patch :update, id: question, question: attributes_for(:invalid_question)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    sign_in_user

    it "should destroy question" do
      question
      expect{delete :destroy, id: question}.to change(Question, :count).by(-1)
    end
    it "should redirect to questions list" do
      delete :destroy, id: question
      expect(response).to redirect_to questions_path
    end
  end

  describe 'POST #favourite' do
    before(:each) do
      request.env["HTTP_REFERER"] = question_path(question)
      sign_in user
      post :favourite, id: question, type: 'favourite'
    end

    let(:user) {create(:user)}
    let(:another_question) {create(:question)}

    it 'should assign favourite question to @question' do
      expect(assigns(:question)).to eq question
    end

    context 'with type: favourite' do
      it 'should add question to user favourite' do
        expect{post :favourite, id: another_question, type: 'favourite'}.to change(user.favourites, :count).by(1)
      end

      it 'should not add to favourites if question is already there' do
        expect{post :favourite, id: question, type: 'favourite'}.not_to change(user.favourites, :count)
      end
    end

    context 'with type: unfavourite' do
      it 'should remove question from user favourites' do
        expect{post :favourite, id: question, type: 'unfavourite'}.to change(user.favourites, :count).by(-1)
      end
    end

    it 'should not work with non-authenticated user' do
      sign_out user
      expect{post :favourite, id: question, type: 'favourite'}.not_to change(user.favourites, :count)
    end
  end
end
