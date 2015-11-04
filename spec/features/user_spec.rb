require 'rails_helper'

feature %q{
  In order to get information about user
  As a user
  I want to be able to look at his profile
} do
  given(:user) {create(:user)}
  given(:author) {create(:user)}
  given(:question) {create(:question, user: author)}

  scenario 'Guest visit user profile' do 
    visit question_path(question)
    click_on author.email

    expect(page).to have_content author.email
    expect(page).to have_content question.title
  end

  scenario 'User visits hiw own profile' do
    sign_in(user)
    visit root_path
    within '.nav' do
      click_on user.email
    end

    expect(current_path).to eq user_path(user)
    expect(page).to have_content user.email
  end
end