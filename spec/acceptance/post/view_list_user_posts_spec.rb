require 'acceptance/acceptance_helper'

feature 'User view list own posts' do
  given(:user) { create(:user) }
  given!(:posts) { create_list(:post, 3) }
  given!(:user_posts) { create_list(:post, 3, user: user) }

  describe 'Authenticated user' do
    before do
      sign_in user
      visit root_path
    end

    scenario 'view link to own post' do
      expect(page).to have_link 'My Posts'
    end

    scenario 'view list own post' do
      click_on 'My Posts'

      user_posts.each do |p|
        expect(page).to have_content p.title
      end
    end

    scenario 'not view all post in list own post ' do
      click_on 'My Posts'

      posts.each do |p|
        expect(page).to_not have_content p.title
      end
    end
  end

  scenario 'Non-authenticated user not view link to own post' do
    visit root_path

    expect(page).to_not have_link 'My Posts'
  end
end
