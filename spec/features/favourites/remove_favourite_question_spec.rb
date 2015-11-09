require 'rails_helper'

feature 'Remove question from favourites', %q{
  In order to unsee useless question
  As a user
  I want to be able to remove quesition from favourites
} do
  let(:user) {create(:user)}
  let(:question) {create(:question)}

  background do
    sign_in(user)
    visit question_path(question)
    click_on 'Favourite question'
  end

  scenario 'User remove question from question page' do
    visit question_path(question)
    click_on 'Remove from favourites'

    expect(page).to have_content 'Favourite question'
    expect(page).not_to have_content 'Remove from favourites'

    visit user_path(user)

    expect(page).not_to have_content question.title
  end

  scenario 'User remove question from profile page' do
    visit user_path(user)
    click_link('', href: "/questions/#{question.id}/remove_favourite")

    within '.favourites' do
      expect(page).not_to have_content question.title
    end 

    visit question_path(question)
    expect(page).to have_content 'Favourite question'
  end

end