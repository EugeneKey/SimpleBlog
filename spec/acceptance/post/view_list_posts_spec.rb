require 'acceptance/acceptance_helper'

feature 'View list posts', '
  All user can do it

' do
  given(:user) { create(:user) }
  given!(:posts) { create_list(:post, 5, user: user) }

  scenario 'Authenticated user view list posts' do
    sign_in(user)
    visit root_path

    posts.each do |p|
      expect(page).to have_content p.title
    end
  end

  scenario 'Non-authenticated user view list posts' do
    visit root_path

    posts.each do |p|
      expect(page).to have_content p.title
    end
  end
end
