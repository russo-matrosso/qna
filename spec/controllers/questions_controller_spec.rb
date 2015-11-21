require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) {create(:question)}
  let(:user) {create(:user)}

  before(:each) do |example|
    sign_in user if example.metadata[:sign_in]
    request.env["HTTP_REFERER"] = question_path(question) if example.metadata[:redirect_back]
  end

  describe "GET #index" do
    let(:questions) {create_list(:question, 2)}

    before {get :index}

    it "should populate the array of questions" do
      expect(assigns(:questions)).to match_array(questions)
    end

    it "should render the 'index' view" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before {get :show, id: question}

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

  describe "GET #new", sign_in: true do
    before {get :new}

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

  describe "GET #edit", sign_in: true do
    before {get :edit, id: question}

    it "should assign the requested question to @question" do
      expect(assigns(:question)).to eq question
    end

    it "shoult render a 'edit question' template" do
      expect(response).to render_template :edit
    end
  end

  describe "POST #create", sign_in: true do
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

  describe "PATCH #update", sign_in: true do
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

  describe "DELETE #destroy", sign_in: true do
    it "should destroy question" do
      question
      expect{delete :destroy, id: question}.to change(Question, :count).by(-1)
    end
    it "should redirect to questions list" do
      delete :destroy, id: question
      expect(response).to redirect_to questions_path
    end
  end

  describe 'POST #add_favourite', redirect_back: true  do
    context 'authorisated user', sign_in: true do
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

  describe 'POST #remove_favourite', redirect_back: true do
    before {user.favourites << question}

    context 'authorisated user', sign_in: true do
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

  describe 'POST #vote_up', sign_in: true, redirect_back: true  do
    it 'should vote up question' do
      expect{post :vote_up, id: question}.to change(question.votes, :count).by(1)
    end
  end

  describe 'POST #vote_down', sign_in: true, redirect_back: true  do
    before {user.vote_for(question)}

    it 'should vote down' do
      expect{post :vote_down, id: question}.to change(question.votes, :count).by(-1)
    end
  end
end
