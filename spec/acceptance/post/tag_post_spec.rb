require 'acceptance/acceptance_helper'

feature 'Create post with tag' do
  given(:user) { create(:user) }
  given(:post) { create(:post) }

  given(:tagged_post) { create_list(:tagged_post, 3) }

  scenario 'Authenticated user create post with text' do
    sign_in(user)

    visit root_path
    click_link 'Create Post'
    fill_in 'Title', with: 'Test post'
    fill_in 'Body', with: 'Some text for post'
    fill_in 'Tags (separated by commas)', with: 'Tag1, Tag2, Tag3'
    click_button 'Create Post'

    expect(page).to have_content 'Post was successfully created. And successfully published.'
    expect(page).to have_content 'Some text for post'
    expect(page).to have_link 'Tag1'
    expect(page).to have_link 'Tag2'
    expect(page).to have_link 'Tag3'
    expect(current_path).to eq post_path(post.id - 1)
  end

  scenario 'User open list tagged posts when click on tag link' do
    post
    tagged_post

    visit post_path(tagged_post[1])

    click_on 'factory_tag'

    tagged_post.each do |p|
      expect(page).to have_content p.title
    end

    expect(page).to_not have_content post.title
  end

  scenario 'User view cloud tags in root page' do
    tagged_post

    visit root_path
    
    expect(page).to have_link 'factory_tag'
    expect(page).to have_link 'tag_cloud1'
    expect(page).to have_link 'tag_cloud2'
  end

  scenario 'User open list tagged posts when click on tag link in cloud tags' do
    post
    tagged_post

    visit root_path

    click_on 'tag_cloud1'

    tagged_post.each do |p|
      expect(page).to have_content p.title
    end

    expect(page).to_not have_content post.title
  end
end
