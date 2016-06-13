require 'acceptance/acceptance_helper'

feature 'Delete post' do
  given(:user) { create(:user) }
  given(:post) { create(:post) }

  scenario 'delete post' do
    sign_in(user)

    visit post_path(post)
    click_on 'Delete'

    expect(page).to have_content 'Post was successfully destroyed.'
    expect(page).to_not have_content 'Title Post'
    expect(current_path).to eq posts_path
  end
end
