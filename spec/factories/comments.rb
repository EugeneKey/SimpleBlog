FactoryGirl.define do
  factory :comment do
    association(:post)
    sequence(:body) { |i| "Text Comment #{i}" }
  end
end
