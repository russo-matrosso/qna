require 'rails_helper'

feature 'Author can delete his answer', %q{
  In order to disable wrong answer
  As an author of the answer
  I want to be able to delete the answer
} do
  given(:user) {create(:user)}
  given(:question) {create(:question, user: user)}
  given!(:answer) {create(:answer, user: user, question: question)}

  # scenario 'Unauthenticated user tryes to delete answer' do
  #   visit question_path(question)

  #   expect(page).not_to have_link 'Delete'
  # end

  scenario 'Authenticated user of the answer tryes to delete it', js: true do
    sign_in user
    visit question_path(question)

    within '.answers' do
      click_on 'Delete'
    end

    expect(page).not_to have_content answer.body
  end
end