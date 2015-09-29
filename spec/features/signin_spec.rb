require 'rails_helper'

feature "User sign in", %q{
  In order to be able to ask questions
  As an user
  I want to be able to sign in
} do

  scenario "Registered user tryes to sig in" do
    User.create!(email: 'user@example.com', password: 'foobar123')

    visit new_user_session_path
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'foobar123'
    click_on 'Log in'
    # save_and_open_page
    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario "Unregistered user tryes to sign in" do
    visit new_user_session_path
    fill_in 'Email', with: 'unreg_user@example.com'
    fill_in 'Password', with: 'foobar123'
    click_on 'Log in'

    expect(page).to have_content 'Invalid email or password.'
    expect(current_path).to eq new_user_session_path
  end
end