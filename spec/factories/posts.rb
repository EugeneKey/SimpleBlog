FactoryGirl.define do
  factory :post do
    association(:user)
    sequence(:title) { |i| "Title Post #{i}" }
    body 'Text Post'
  end

  factory :unpublishing_post, class: 'Post' do
    association(:user)
    sequence(:title) { |i| "Unpublishing title post #{i}" }
    body 'Text Post'
    publish false
  end

  factory :tagged_post, class: 'Post' do
    association(:user)
    sequence(:title) { |i| "Tagged title post #{i}" }
    body 'Text Post'
    tag_list 'factory_tag, tag_cloud1, tag_cloud2'
  end
end
