require 'rails_helper'

feature 'User can edit answer', %q{
  In order to make answer correct
  As an author
  User can be able to edit his question
} do

  given(:user) {create(:user)}
  given(:other_user) {create(:user)}
  given(:question) {create(:question, user: user)}
  given!(:answer) {create(:answer, user: user, question: question)}

  scenario 'Unauthenticated user tryes to edit answer' do
    visit question_path(question)

    within '.answers' do
      expect(page).not_to have_link 'Edit'
    end
  end

  describe 'Author of the question' do
    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'sees link to Edit answer', js: true  do
      within '.answers' do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'tryes to edit his answer', js: true do
      
      within '.answers' do
        click_on 'Edit'
        fill_in 'Answer', with: 'Edited answer'
        click_on 'Save'
      end

      expect(page).not_to have_content answer.body
      expect(page).to have_content 'Edited answer'
      within '.answers' do
        expect(page).not_to have_selector 'textarea'
      end
    end
  end


  scenario 'Authenticated user tryes to edit others answer' 
    # sign_in other_user
    # visit question_path(question)

    # within '.answers' do
    #   expect(page).not_to have_link 'Edit'
    # end
end