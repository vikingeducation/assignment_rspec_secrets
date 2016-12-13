FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foouser#{n}@email.com"}
    password "password"

  end

  factory :secret do
    title "Secret Title"
    body  "Foo Paragraph"
    association :author, factory: :user
  end
end
