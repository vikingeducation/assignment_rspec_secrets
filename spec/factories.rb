FactoryGirl.define do
  factory :user do
  sequence(:name) { |n| "user#{n}" }
  email {"#{name}@email.com"}
  password "password"
  trait :bogus_params do
    name ""
    email ""
  end
  end

  factory :secret do
  title "Secret Title"
  body "Foo Paragraph"
  association :author, factory: :user
  end
end
