require 'rails_helper'

RSpec.describe Vote, type: :model do
  it {should belong_to :user}
  it {should belong_to :votable}

  describe '#increase_votes_sum' do
    let(:question) {create(:question)}
    let(:answer) {create(:answer, question_id: question, user_id: user)}
    let(:user) {create(:user)}

    describe 'if positive' do
      it 'increase question votes sum' do
        user.vote_up_for(question)
        question.reload
        expect(question.votes_sum).to eq 1
      end

      it 'increase answer votes sum' do
        user.vote_up_for(answer)
        answer.reload
        expect(answer.votes_sum).to eq 1
      end
    end

    describe 'if negative' do
      it 'decrease question votes sum' do
        user.vote_down_for(question)
        question.reload
        expect(question.votes_sum).to eq -1
      end

      it 'decrease answer votes sum' do
        user.vote_down_for(answer)
        answer.reload
        expect(answer.votes_sum).to eq -1
      end
    end
  end

  describe '#decrease_votes_sum' do
    let(:question) {create(:question)}
    let(:answer) {create(:answer, question_id: question, user_id: user)}
    let(:user) {create(:user)}

    describe 'if positive' do
      it 'decrease question votes sum' do
        user.vote_up_for(question)
        question.reload
        user.unvote(question)
        question.reload
        expect(question.votes_sum).to eq 0
      end

      it 'decrease answer votes sum' do
        user.vote_up_for(answer)
        answer.reload
        user.unvote(answer)
        answer.reload
        expect(answer.votes_sum).to eq 0
      end
    end

    describe 'if negative' do
      it 'decrease question votes sum' do
        user.vote_down_for(question)
        question.reload
        user.unvote(question)
        question.reload
        expect(question.votes_sum).to eq 0
      end

      it 'decrease answer votes sum' do
        user.vote_down_for(answer)
        answer.reload
        user.unvote(answer)
        answer.reload
        expect(answer.votes_sum).to eq 0
      end
    end
  end
end
