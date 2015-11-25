require 'rails_helper'

RSpec.describe Vote, type: :model do
  it {should belong_to :user}
  it {should belong_to :votable}

  describe '#increase_votes_sum' do
    let(:question) {create(:question)}
    let(:answer) {create(:answer, question_id: question, user_id: user)}
    let(:user) {create(:user)}

    it 'increase question votes sum' do
      question.votes.create(user: user)
      question.reload
      expect(question.votes_sum).not_to eq 0
    end

    it 'increase answer votes sum' do
      answer.votes.create(user: user)
      answer.reload
      expect(answer.votes_sum).not_to eq 0
    end
  end

  describe '#decrease_votes_sum' do
    let(:question) {create(:question)}
    let(:answer) {create(:answer, question_id: question, user_id: user)}
    let(:user) {create(:user)}

    it 'decrease question votes sum' do
      question.votes.create(user: user)
      question.reload
      user.vote_down_for(question)
      question.reload
      expect(question.votes_sum).to eq 0
    end

    it 'decrease answer votes sum' do
      answer.votes.create(user: user)
      answer.reload
      user.vote_down_for(answer)
      answer.reload
      expect(answer.votes_sum).to eq 0
    end
  end
end
