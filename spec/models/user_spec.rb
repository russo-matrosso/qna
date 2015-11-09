require 'rails_helper'

RSpec.describe User do
  it {should validate_presence_of :email}
  it {should validate_presence_of :password}

  it {should have_many :questions}
  it {should have_many :answers}
  it {should have_many :favourite_questions}
  it {should have_many :favourites}

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
end
