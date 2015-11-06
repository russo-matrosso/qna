require "rails_helper"

feature %q{
  To have useful materials saved
  As a user
  I want to be able to save question
} do
  given(:user) {create(:user)}
  given(:author) {create(:user)}
  given(:question) {create(:question, user: author)}


  scenario 'User saves question to his profile from question page' do
    sign_in(user)

    visit question_path(question)
    click_on 'Favourite question'

    expect(page).to have_content "You favorited #{question.title}"
    expect(page).not_to have_content 'Favourite question'

    visit user_path(user)
    expect(page).to have_content question.title
  end

  scenario 'Guest does not see the linnk to favourite' do
    visit question_path(question)

    expect(page).not_to have_content 'Favourite question'
  end
end