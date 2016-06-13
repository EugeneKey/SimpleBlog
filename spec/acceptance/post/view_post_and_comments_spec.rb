require 'acceptance/acceptance_helper'

feature 'View the post and all comments to it', '
  All user can do it

' do
given(:user) { create(:user) }
  given!(:post) { create(:post) }
  given!(:comments) { create_list(:comment, 3, post: post) }

  scenario 'Authenticated user view post and comments' do
    visit root_path
    click_on post.title

    expect(page).to have_content post.body
    comments.each do |c|
      expect(page).to have_content c.body
    end
  end

  scenario 'Non-authenticated user view post and comments' do
    visit root_path
    click_on post.title

    expect(page).to have_content post.body
    comments.each do |c|
      expect(page).to have_content c.body
    end
  end
end
