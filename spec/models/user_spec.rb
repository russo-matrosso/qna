require 'rails_helper'

RSpec.describe User do
  it {should validate_presence_of :email}
  it {should validate_presence_of :password}

  it {should have_many :questions}
  it {should have_many :answers}
  it {should have_many :favourite_questions}
  it {should have_many :favourites}
  it {should have_many :votes}
  
  describe '#add_favourite' do
    let(:user) {create(:user)}
    let(:question) {create(:question)}

    it 'add question to user favourite questions if qestion is given' do
      expect{user.add_favourite(question)}.to change(user.favourites, :count).by(1)
    end

    it 'shoud not add to user favourites if it is already there' do
      user.add_favourite(question)
      expect{user.add_favourite(question)}.not_to change(user.favourites, :count)
    end
  end

  describe '#remove_favourite' do
    let(:user) {create(:user)}
    let(:question) {create(:question)}

    before {user.favourites << question}

    it 'removes question from favourites' do
      expect{user.remove_favourite(question)}.to change(user.favourites, :count).by(-1)
    end
  end

  describe '#favourited?' do
    let(:user) {create(:user)}
    let(:question) {create(:question)}

    it 'should return true if question is favourited bu user' do
      user.favourites << question
      expect(user.favourited?(question)).to be true
    end

    it 'should return false if question is not favourited by user' do
      expect(user.favourited?(question)).to be false
    end
  end

  describe '#vote_for' do
    let (:user) {create(:user)}
    let (:question) {create(:question)}

    it 'make new vote for question' do
      expect{user.vote_for(question)}.to change(Vote, :count).by(1)
    end

    it 'assign user to the vote' do
      user.vote_for(question)
      expect(question.votes.last.user).to eq user
    end
  end

  describe '#vote_down_for' do
    let (:user) {create(:user)}
    let (:question) {create(:question)}

    before {user.vote_for(question)}

    it 'deletes vote for question' do
      expect{user.vote_down_for(question)}.to change(question.votes, :count).by(-1)
    end
  end

  describe '#voted_for?' do
    let (:user) {create(:user)}
    let (:question) {create(:question)}

    it 'should return true if user has voted for question' do
      user.vote_for(question)
      expect(user.voted_for?(question)).to be true
    end
  end
end
