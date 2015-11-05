require "rails_helper"

feature %q{
  To have useful materials saved
  As a user
  I want to be able to save question
} do
  given(:user) {create(:user)}
  given(:author) {create(:user)}
  given(:question) {create(:question, user: author)}

  scenario 'User saves question to his profile' do
    sign_in(user)

    visit question_path(question)
    click_on 'Save question'
    expect(page).to have_content 'Question has been saved'

    visit user_path(user)
    expect(page).to have_content question.title
  end
end