require 'rails_helper'

feature 'User answer', %q{
        In order to exchange my knowledge
        As aa authenticated user
        I want to be able to answer questions
} do

  given(:user) {create(:user)}
  given(:question) {create(:question, user: user)}

  scenario 'Authenticated user creates answer' , js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Your answer', with: 'my answer'
    click_on 'Create answer'

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'my answer'
      expect(page).to have_content user.email
    end
  end

  scenario 'Authenticated user creates bad answer', js: true do
    sign_in(user)
    visit question_path(question)

    click_on 'Create answer'

    expect(page).to have_content "Body can't be blank"
  end
end