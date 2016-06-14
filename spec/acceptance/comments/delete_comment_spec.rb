require 'acceptance/acceptance_helper'

feature 'Delete comment', '
  Only the owner can remove the comment

' do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:post) { create(:post) }
  given!(:comment) { create(:comment, post: post, user: user) }
  given!(:old_comment) { create(:old_comment, post: post, user: user) }

  scenario 'Authenticated user delete own comment', js: true do
    sign_in(user)
    visit post_path(post)
    
    within "#comment-#{comment.id}" do
      expect(page).to have_content comment.body
      click_on 'Delete'
    end

    expect(page).to_not have_content comment.body
    expect(current_path).to eq post_path(post)
  end

  scenario 'Authenticated user cannot delete own old comment', js: true do
    sign_in(user)
    visit post_path(post)
    
    within "#comment-#{old_comment.id}" do
      expect(page).to have_content old_comment.body
      expect(page).to_not have_link 'Delete'
    end
  end

  scenario 'Authenticated user cannot delete foreign comment' do
    sign_in(another_user)
    visit post_path(post)

    within "#comment-#{comment.id}" do
      expect(page).to have_content comment.body
      expect(page).to_not have_link 'Delete'
    end
  end

  scenario 'Non-authenticated user cannot delete post' do
    visit post_path(post)

    within "#comment-#{comment.id}" do
      expect(page).to have_content comment.body
      expect(page).to_not have_link 'Delete'
    end
  end
end
