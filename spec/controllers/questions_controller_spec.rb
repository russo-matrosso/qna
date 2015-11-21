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

  describe 'POST #add_favourite' do
    let(:user) {create(:user)}
    let(:question) {create(:question)}

    before {request.env["HTTP_REFERER"] = question_path(question)}

    context 'authorisated user' do
      before {sign_in user}

      it 'should assign favourite question to @question' do
        post :add_favourite, id: question
        expect(assigns(:question)).to eq question
      end

      it 'should add question to user favourite questions' do
        expect{post :add_favourite, id: question}.to change(user.favourites, :count).by(1)
      end
    end

    context 'unauthorisated user' do
      it 'sdould not add question to user favourite questions' do
        expect{post :add_favourite, id: question}.not_to change(user.favourites, :count)
      end
    end
  end

  describe 'POST #remove_favourite' do
    let(:user) {create(:user)}
    let(:question) {create(:question)}

    before do
      user.favourites << question
      request.env["HTTP_REFERER"] = question_path(question)
    end

    context 'authorisated user' do
      before {sign_in user}

      it 'should assign favourite question to question' do
        post :remove_favourite, id: question
        expect(assigns(:question)).to eq question
      end

      it 'should remove qeustion from user favourites' do
        expect{post :remove_favourite, id: question}.to change(user.favourites, :count).by(-1)
      end
    end

    context 'unauthorisated user' do
      it 'should not remove qeustion from user favourites' do
        expect{post :remove_favourite, id: question}.not_to change(user.favourites, :count)
      end
    end
  end

  describe 'POST #vote_up' do
    let(:user) {create(:user)}
    let(:question) {create(:question)}

    before {request.env["HTTP_REFERER"] = question_path(question)}

    it 'should vote up question' do
      sign_in user
      expect{post :vote_up, id: question}.to change(question.votes, :count).by(1)
    end
  end

  describe 'POST #vote_down' do
    let(:user) {create(:user)}
    let(:question) {create(:question)}

    before do
      request.env["HTTP_REFERER"] = question_path(question)
      sign_in user
      user.vote_for(question)
    end

    it 'should vote down' do
      expect{post :vote_down, id: question}.to change(question.votes, :count).by(-1)
    end
  end
end
