FactoryGirl.define do

  sequence(:name) do |n|
    "foo#{n}"         # e.g. "foo312"
  end

  factory :user, aliases: [:author] do
    name
    email       {"#{name}@bar.com"}
    password    "foobar"
  end
end
