FactoryGirl.define do
  factory :user do
    name "foo"
    email "#{name}@email.com"
    password "password"
    association :secrets
  end

  factory :secrets do
    title "Secret Title"
    body  "Foo Paragraph"
    association :user
  end
end
