require 'acceptance/acceptance_helper'

feature 'User sign in', '
  In order to be able to create post
  As an User
  I want to be able to sign in

' do
  given(:user) { create(:user) }

  scenario 'Registered user try to sign in' do
    sign_in(user)

    expect(page).to have_content 'Signed in successfully'
    expect(current_path).to eq root_path
  end

  scenario 'Authenticated user try to sign out' do
    sign_in(user)
    sign_out

    expect(page).to have_content 'Signed out successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
    expect(current_path).to eq new_user_session_path
  end
end
