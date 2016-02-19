FactoryGirl.define do
  factory :secret do
    sequence(:title){ |n| "Secret #{n}" }
    sequence(:body){ |n| "This is secret number #{n}." }
    author
  end
end