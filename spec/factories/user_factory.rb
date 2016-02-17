FactoryGirl.define do
  factory :user, aliases: [:author] do
    name     "Foo Bar"
    email    "foo@bar.com"
    password "foobar"
  end
end