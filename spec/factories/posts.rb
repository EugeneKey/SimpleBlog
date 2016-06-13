FactoryGirl.define do
  factory :post do
    association(:user)
    sequence(:title) { |i| "Title Post #{i}" }
    body 'Text Post'
  end
end
