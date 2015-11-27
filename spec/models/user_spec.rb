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
      context 'others entry' do
        context 'if user have not voted' do
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

        context 'if user have voted' do
          it 'does not change entry' do
            user.vote_up_for(question)
            expect{user.vote_up_for(question)}.not_to change(question.votes, :count)
          end
        end
      end

      context 'his entry' do
        it 'does not change entry' do
          expect{user.vote_up_for(his_question)}.not_to change(his_question.votes, :count)
        end
      end
    end

    describe '#vote_down_for' do
      context 'others entry' do
        context 'if user have not voted' do
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

        context 'if user have voted' do
          it 'does not change entry' do
            user.vote_down_for(question)
            expect{user.vote_down_for(question)}.not_to change(question.votes, :count)
          end
        end
      end

      context 'his entry' do
        it 'does not change entry' do
          expect{user.vote_down_for(his_question)}.not_to change(his_question.votes, :count)
        end
      end
    end

    describe '#unvote' do
      context 'if user have voted' do
        before {user.vote_up_for(question)}

        it 'deletes vote for entry' do
          expect{user.unvote(question)}.to change(question.votes, :count).by(-1)
        end
      end

      context 'if user have not voted' do
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

  describe '.find_for_oauth' do
    let!(:user) {create(:user)}
    let(:auth) {OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456')}

    context 'existing user with authorization' do
      it 'returns the user' do
        user.authorizations.create(provider: 'facebook', uid: '123456')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end

    context 'user has no authorization' do
      context 'existing user' do
        let(:auth) {OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: {email: user.email})}
        it 'should not creat new user' do
          expect{User.find_for_oauth(auth)}.to_not change(User, :count)
        end

        it 'should create new authorization for user' do
          expect{User.find_for_oauth(auth)}.to change(user.authorizations, :count).by(1)
        end

        it 'creates uathotization with provider and uid' do
          user = User.find_for_oauth(auth)
          authorization = user.authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end
      end

      context 'user does not exists' do
        let(:auth) {OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: {email: 'new@mail.com'})}

        it 'creates new user' do
          expect{User.find_for_oauth(auth)}.to change(User, :count).by(1)
        end

        it 'returns new user' do
           expect(User.find_for_oauth(auth)).to be_a(User)
        end

        it 'fills user email' do
          user = User.find_for_oauth(auth)
          expect(user.email).to eq 'new@mail.com'
        end

        it 'creates authorization for user' do
          user = User.find_for_oauth(auth)
          expect(user.authorizations).to_not be_empty
        end

        it 'creates authorization with provider and id' do
          authorization = User.find_for_oauth(auth).authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end
      end
    end
  end
end
