require 'acceptance/acceptance_helper'

feature 'Comment editing', '
  In order to fix mistake
  As an author comment
  I want to be able to edit my comment
' do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:post) { create(:post) }
  given!(:comment) { create(:comment, post: post, user: user) }

    describe 'Author' do
    before do
      sign_in user
      visit post_path(post)
    end

    scenario 'sees link to edit his comment' do
      within '.comment-options' do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'try to edit his comment', js: true do
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

  scenario "Authenticated user try to edit other user's comment" do
    sign_in another_user
    visit post_path(post)

    within '.comment-options' do
      expect(page).to_not have_link 'Edit'
    end
  end

  scenario 'Non-authenticated user trying to edit answer' do
    visit post_path(post)

    within '.comment-options' do
      expect(page).to_not have_link 'Edit'
    end
  end

end
