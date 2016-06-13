FactoryGirl.define do
  factory :comment do
    association(:post)
    association(:user)
    sequence(:body) { |i| "Text Comment #{i}" }
  end
end
