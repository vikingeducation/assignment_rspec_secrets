FactoryGirl.define do
  factory :user do
    name "foobarbaz"
    email {"#{name}@email.com"}
    password "password"

  end

  factory :secrets do
    title "Secret Title"
    body  "Foo Paragraph"
    association :user
  end
end
