require 'rails_helper'

feature 'Create question', %q{
  In order to get an answer
  as an authenicated user
  I want to be able to ask questions
} do

  given(:user) {create(:user)}

  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit questions_path
    click_on 'New question'
    fill_in 'Title', with: 'Question title'
    fill_in 'Body', with: 'Question body'
    click_on 'Create question'

    expect(page).to have_content 'Your question has been created'
  end

  scenario 'Non-authenticated user tryes to create question' do
    visit questions_path
    click_on 'New question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end