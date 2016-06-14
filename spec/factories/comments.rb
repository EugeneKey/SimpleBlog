FactoryGirl.define do
  factory :comment do
    association(:post)
    association(:user)
    sequence(:body) { |i| "Text Comment #{i}" }
  end

  factory :old_comment, class: 'Comment'  do
    association(:post)
    association(:user)
    sequence(:body) { |i| "Text Old Comment #{i}" }
    created_at { 16.minutes.ago }
  end
end
