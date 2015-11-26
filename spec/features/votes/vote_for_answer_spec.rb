require 'rails_helper'

feature 'Vote for answer', %q{
  In order to show opinion
  As user
  I want to be able to vote for good answer
} do
  let (:user) {create(:user)}
  let (:question) {create(:question)}

  context 'User vote for another user answer' do
    let! (:answer) {create(:answer, question: question)}

    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'User upvote for answer' do
      within '.answers' do 
        click_on 'Vote up'
      end

      within '.answers' do
        expect(page).not_to have_content 'Vote up'
        expect(page).to have_content 'Unvote'
        expect(page).to have_content '1'
      end
    end

    scenario 'User downvote for answer' do
      within '.answers' do
        click_on 'Vote down'
      end

      within '.answers' do
        expect(page).not_to have_content 'Vote down'
        expect(page).to have_content 'Unvote'
        expect(page).to have_content '-1'
      end
    end

    scenario 'User unvote answer' do
      within '.answers' do
        click_on 'Vote up'
      end

      click_on 'Unvote'

      within '.answers' do
        expect(page).to have_content 'Vote up'
        expect(page).to have_content 'Vote down'
        expect(page).to have_content '0'
      end
    end
  end

  context 'User vote for his answer' do 
    let! (:answer) {create(:answer, question: question, user: user)}

    scenario 'User can not vote' do
      sign_in(user)
      visit question_path(question)

      within '.answers' do
        expect(page).not_to have_content 'Vote up'
        expect(page).not_to have_content 'Vote down'
        expect(page).not_to have_content 'Unvote'
      end
    end
  end
end