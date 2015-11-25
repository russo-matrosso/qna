require 'rails_helper'

feature 'Edit question', %q{
  In order to make my question correct
  As an authenticated user
  I want to be able to edit my question
} do

  given(:user) {create(:user)}
  given(:question) {create(:question, user: user)}

  scenario 'Authenticated user edit his question' do
    sign_in(user)

    visit question_path(question)
    click_on 'Edit question'
    fill_in 'Title', with: 'New question title'
    fill_in 'Body', with: 'New question body'
    click_on 'Edit question'

    expect(page).to have_content 'Your Question has been successfully updated'
    expect(current_path).to eq question_path(question)
    expect(page).to have_content 'New question title'
    expect(page).to have_content 'New question body'
  end

  scenario 'Authenticated user tryes to edit not his question' do
    @question = create(:question, user: create(:user))

    sign_in(user)

    visit question_path(@question)
    expect(page).not_to have_link 'Edit question'
  end
end