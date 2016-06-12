require 'rails_helper'

feature 'Delete post' do

  given(:post) { create(:post) }

  scenario 'delete post' do

    visit post_path(post)
    click_on 'Delete'

    expect(page).to have_content 'Post was successfully destroyed.'
    expect(page).to_not have_content 'Title Post'
    expect(current_path).to eq posts_path
  end
end
