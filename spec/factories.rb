FactoryGirl.define do
  factory :user, aliases: [:author] do
    sequence(:name){|n| "foobar#{n}" }
    email { "#{name}@email.com" }
    password "123456"
  end

  factory :secret do
    title "this is title"
    body "this is body"
    author
  end
end
