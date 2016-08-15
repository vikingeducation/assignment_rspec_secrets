FactoryGirl.define do
  factory :secret do
    author
    sequence(:title) { |n| "title#{n}"}
    sequence(:body) { |n| "body#{n}"}


  end
end