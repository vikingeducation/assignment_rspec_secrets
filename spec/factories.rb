FactoryGirl.define do
  factory :user do
    sequence(:name){ |n| "TestUser#{n}" }
    email { "#{name}@example.com" }
    password Faker::Internet.password(10, 20)
  end

  factory :secret do
    sequence(:title) { |t| "TestSecret#{t}" }
    body { "This is the body of #{title}!" }
    association :author, factory: :user
  end
end
