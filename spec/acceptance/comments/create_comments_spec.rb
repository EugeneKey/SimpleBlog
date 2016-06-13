require 'acceptance/acceptance_helper'

feature 'Add comments to post' do

  given(:user) { create(:user) }
  given!(:post) { create(:post) }

  scenario 'Authenticated user add comments to post', js: true do
    sign_in user
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

scenario 'Authenticated user try to add blank comment', js: true do
    sign_in(user)
    visit post_path(post)

    click_on 'Add comment'

    expect(page).to have_content "Body can't be blank"
  end

  scenario 'Non-authenticated user trying to create answer', js: true do
    visit post_path(post)
    expect(page).to_not have_content 'Your comment'
  end
end
