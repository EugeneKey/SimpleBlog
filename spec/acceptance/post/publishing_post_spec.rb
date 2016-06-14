require 'acceptance/acceptance_helper'
feature 'Create post' do 

  given(:user) { create(:user) }
  given(:post) { create(:post) }
  given(:unpublishing_post) { create(:unpublishing_post, user: user) }

  describe 'Authenticated user' do
    before do
      sign_in user
      visit root_path
      click_link 'Create Post'
      fill_in 'Title', with: 'Test post'
      fill_in 'Body', with: 'Some text for post'
    end

    scenario 'sees publishing post options' do
      expect(page).to have_content 'Publishing this post'
    end

    scenario 'create unpublishing post' do

      uncheck 'Publishing this post'

      click_button 'Create Post'

      expect(page).to have_content 'Post was successfully created. But not publishing.'
      expect(page).to have_content 'Some text for post'
      expect(current_path).to eq post_path(post.id - 1)
    end
  end

  scenario 'Not view unpublishing posts' do
    sign_in user
    post
    unpublishing_post
    visit root_path

    expect(page).to have_content post.title
    expect(page).to_not have_content unpublishing_post.title
  end

end
