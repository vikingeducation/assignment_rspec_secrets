FactoryGirl.define do

  factory :user, aliases: [:author] do
    sequence(:name) { |n| "foo#{n}" }
    email { "#{name}@bar.com" }
    password "foobar"
  end

  factory :secret do
    title "Secret Title"
    body "This is a secret body."
    author
  end

end