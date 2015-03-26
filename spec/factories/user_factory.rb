FactoryGirl.define do
  factory :user, aliases: [:author] do
    name      "Foo Bar"
    email     "foobar@baz.com"
    password  "foobarbaz"
  end
end