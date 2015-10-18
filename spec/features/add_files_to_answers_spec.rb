require 'rails_helper'

feature 'Add files to answer', %q{
  In order to make my answer clear
  As author
  I want to be able to add files
} do
  given(:user) {create(:user)}
  given(:question) {create(:question)}

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User adds file to answer', js: true do
    fill_in 'Your answer', with: 'my answer'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create answer'

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb'
    end
  end
end