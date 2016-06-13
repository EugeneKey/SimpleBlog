require 'acceptance/acceptance_helper'

feature 'Delete comment' do
  given(:post) { create(:post) }
  given!(:comment) { create(:comment, post: post) }

  scenario 'user delete comment', js: true do
    visit post_path(post)
    expect(page).to have_content comment.body
    
    within '.list-comments' do
      click_on 'Delete'
    end

    expect(page).to_not have_content comment.body
    expect(current_path).to eq post_path(post)
  end
end
