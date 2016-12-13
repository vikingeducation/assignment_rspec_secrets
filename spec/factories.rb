FactoryGirl.define do
  factory :user, aliases: [:author] do
    sequence(:name) { |n| "foo#{n}" }
    sequence(:email) { |n| "#{name}@bar.com" }
    password  "foobar"
  end

  factory :secret do
    title     "foo title"
    body      "foo body"
    author
  end
end
