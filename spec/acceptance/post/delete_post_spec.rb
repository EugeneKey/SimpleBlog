require 'acceptance/acceptance_helper'

feature 'Delete post', '
Only the owner can remove the post

' do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:post) { create(:post, user: user) }

  scenario 'Authenticated user delete own post' do
    sign_in(user)

    visit post_path(post)
    click_on 'Delete'

    expect(page).to have_content 'Post was successfully destroyed.'
    expect(page).to_not have_content 'Title Post'
    expect(current_path).to eq posts_path
  end

  scenario 'Authenticated user cannot delete foreign post' do
    sign_in(another_user)
    visit post_path(post)

    expect(page).to_not have_content 'Delete'
  end

  scenario 'Non-authenticated user cannot delete post' do
    visit post_path(post)

    expect(page).to_not have_content 'Delete'
  end
end
