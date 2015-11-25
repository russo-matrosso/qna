require 'rails_helper'

RSpec.describe User do
  it {should validate_presence_of :email}
  it {should validate_presence_of :password}

  it {should have_many :questions}
  it {should have_many :answers}
  it {should have_many :favourite_questions}
  it {should have_many :favourites}
  it {should have_many :votes}

  describe 'Favourites' do
    let(:user) {create(:user)}
    let(:question) {create(:question)}

    describe '#add_favourite' do
      it 'add question to user favourite questions if qestion is given' do
        expect{user.add_favourite(question)}.to change(user.favourites, :count).by(1)
      end

      it 'shoud not add to user favourites if it is already there' do
        user.add_favourite(question)
        expect{user.add_favourite(question)}.not_to change(user.favourites, :count)
      end
    end

    describe '#remove_favourite' do
      before {user.favourites << question}

      it 'removes question from favourites' do
        expect{user.remove_favourite(question)}.to change(user.favourites, :count).by(-1)
      end
    end

    describe '#favourited?' do
      it 'should return true if entry is favourited bu user' do
        user.favourites << question
        expect(user.favourited?(question)).to be true
      end

      it 'should return false if entry is not favourited by user' do
        expect(user.favourited?(question)).to be false
      end
    end
  end

  describe 'Votes' do
    let (:user) {create(:user)}
    let (:another_user) {create(:user)}
    let (:question) {create(:question, user: another_user)}
    let (:his_question) {create(:question, user: user)}

    describe '#vote_for' do
      describe 'others entry' do
        describe 'if user have not voted' do
          it 'make new vote for entry' do
            expect{user.vote_up_for(question)}.to change(Vote, :count).by(1)
          end

          it 'assign user to the vote' do
            user.vote_up_for(question)
            expect(question.votes.last.user).to eq user
          end

          it 'sets .vote to +1' do
            user.vote_up_for(question)
            expect(question.votes.last.vote).to eq 1
          end
        end

        describe 'if user have voted' do
          it 'does not change entry' do
            user.vote_up_for(question)
            expect{user.vote_up_for(question)}.not_to change(question.votes, :count)
          end
        end
      end

      describe 'his entry' do
        it 'does not change entry' do
          expect{user.vote_up_for(his_question)}.not_to change(his_question.votes, :count)
        end
      end
    end

    describe '#vote_down_for' do
      describe 'others entry' do
        describe 'if user have not voted' do
          it 'make new vote for entry' do
            expect{user.vote_down_for(question)}.to change(Vote, :count).by(1)
          end

          it 'assign user to the vote' do
            user.vote_down_for(question)
            expect(question.votes.last.user).to eq user
          end

          it 'sets .vote to -1' do
            user.vote_down_for(question)
            expect(question.votes.last.vote).to eq -1
          end
        end

        describe 'if user have voted' do
          it 'does not change entry' do
            user.vote_down_for(question)
            expect{user.vote_down_for(question)}.not_to change(question.votes, :count)
          end
        end
      end

      describe 'his entry' do
        it 'does not change entry' do
          expect{user.vote_down_for(his_question)}.not_to change(his_question.votes, :count)
        end
      end
    end

    describe '#unvote' do
      describe 'if user have voted' do
        before {user.vote_up_for(question)}

        it 'deletes vote for entry' do
          expect{user.unvote(question)}.to change(question.votes, :count).by(-1)
        end
      end

      describe 'if user have not voted' do
        before {another_user.vote_up_for(question)}

        it 'does not delete vote for entry' do
          expect{user.unvote(question)}.not_to change(question.votes, :count)
        end
      end
    end

    describe '#voted_for?' do
      it 'should return true if user has voted for entry' do
        user.vote_up_for(question)
        expect(user.voted_for?(question)).to be true
      end
    end
  end
end
