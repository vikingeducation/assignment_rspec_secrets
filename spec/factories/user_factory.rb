FactoryGirl.define do
  factory :user, aliases: [:author] do
    name      "Foo Bar"
    sequence :email do |n|
      "foobar#{n}@baz.com"
    end
    password  "foobarbaz"
  end
end
