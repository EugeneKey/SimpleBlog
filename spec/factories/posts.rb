FactoryGirl.define do
  factory :post do
    sequence(:title) { |i| "Title Post #{i}" }
    body 'Text Post'
  end
end
