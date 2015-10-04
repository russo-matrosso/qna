require 'rails_helper'

feature 'Delete questio', %q{
  In order to clean mistake
  As a registered user
  I want to be able to delete my question
} do
  given(:user) {create(:user)}
  given(:question) {create(:question, user: user)}

  scenario 'Author deletes his question' do
    sign_in(user)

    visit question_path(question)
    click_on 'Delete question'
    expect(page).to have_content 'Are you sure?'
    click_on 'Yes'

    expect(current_path).to eq questions_path
    expect(page).to have_content 'Question has been deleted'
  end
end