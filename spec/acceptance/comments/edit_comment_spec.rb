require 'acceptance/acceptance_helper'

feature 'Comment editing', '
  In order to fix mistake
  I want to be able to edit my comment
' do
  given!(:post) { create(:post) }
  given!(:comment) { create(:comment, post: post) }

    scenario 'sees link to edit his comment' do
      visit post_path(post)
      within '.comment-options' do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'try to edit his comment', js: true do
      visit post_path(post)
      within '.comment-options' do
        click_on 'Edit'
      end
      within '.edit_comment' do
        fill_in 'Edit your comment:', with: 'Edited comment'
        click_on 'Save'
      end
      within '.list-comments' do
        expect(page).to_not have_content comment.body
        expect(page).to have_content 'Edited comment'
        expect(page).to_not have_selector 'textarea'
      end
    end

end
