FactoryGirl.define do
  factory :user do
    name "TestUser"
    email { "#{name}@example.com" }
    password Faker::Internet.password(10, 20)
  end
end
