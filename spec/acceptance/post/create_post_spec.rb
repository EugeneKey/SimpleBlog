require 'acceptance/acceptance_helper'

feature 'Create post' do

  given(:post) { create(:post) }

  scenario 'Create post with text' do

    visit root_path
    click_link 'Create Post'
    fill_in 'Title', with: 'Test post'
    fill_in 'Body', with: 'Some text for post'
    click_button 'Create Post'

    expect(page).to have_content 'Post was successfully created.'
    expect(page).to have_content 'Some text for post'
    expect(current_path).to eq post_path(post.id - 1)
  end
end
