FactoryGirl.define do

  factory :user, aliases: [:author] do
    sequence(:name){ |n| "Foo#{n}"}
    email { "#{name}@example.com" }
    password "asdfasdf"
  end

  factory :secret do
    title "test"
    body "body"
    association :author, factory: :user
  end
  
end
