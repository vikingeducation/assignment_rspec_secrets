FactoryBot.define do
  factory :user do
    name "MyString"
    sequence(:email) { |n| "foo#{n}@example.com" }

    password "MyString"
    password_confirmation "MyString"
  end
end
