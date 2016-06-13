require 'acceptance/acceptance_helper'

feature 'Post editing', '
  In order to fix mistake
  As an author post
  I want to be able to edit post

' do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:post) { create(:post, user: user) }

  describe 'Author' do
    before do
      sign_in user
      visit post_path(post)
    end

    scenario 'sees link to edit his post' do
      expect(page).to have_link 'Edit'
    end

    scenario 'try to edit his post' do
      click_on 'Edit'
      fill_in 'Title', with: 'New title his post'
      fill_in 'Body', with: 'New body text his post'
      click_on 'Update Post'

      expect(page).to_not have_content post.title
      expect(page).to_not have_content post.body
      expect(page).to have_content 'New title his post'
      expect(page).to have_content 'New body text his post'
      expect(page).to_not have_selector 'edit_post'
    end
  end
  

  scenario "Authenticated user try to edit other user's post" do
    sign_in another_user
    visit post_path(post)
    expect(page).to_not have_link 'Edit'
  end

    scenario 'Non-authenticated user trying to edit post' do
      visit post_path(post)

      expect(page).to_not have_link 'Edit'
  end
end
