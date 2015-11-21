require 'rails_helper'

feature 'Vote for question', %q{
  In order to show opinion
  As user
  I want to be able to vote for good question
} do
  let (:user) {create(:user)}
  let (:question) {create(:question)}

  scenario 'User vote for question' do
    sign_in(user)
    visit question_path(question)
    click_on 'Vote up'

    within '.votes' do
      expect(page).not_to have_content 'Vote up'
      expect(page).to have_content 'Vote down'
      expect(page).to have_content '1'
    end
  end

  scenario 'User can not vot for his question'
end