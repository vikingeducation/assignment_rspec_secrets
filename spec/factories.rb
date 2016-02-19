FactoryGirl.define do

  factory :user, aliases: [:author] do
    sequence(:name) {|n| "Foo#{n}"}
    email {"#{name}@bar.com"}
    password "password"
  end

  factory :secret do
    title "New title"
    body "Lorem ipsum"
    author
  end
end