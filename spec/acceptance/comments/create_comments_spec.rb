require 'acceptance/acceptance_helper'

feature 'Add comments to post' do

  given!(:post) { create(:post) }

  scenario 'Add comments to post', js: true do

    visit post_path(post)

    within '.new_comment' do
      fill_in 'comment[body]', with: 'Some text for comment'
      click_on 'Add comment'
    end

    within '.list-comments' do
      expect(page).to have_content 'Some text for comment'
    end
    expect(current_path).to eq post_path(post)
  end

end
