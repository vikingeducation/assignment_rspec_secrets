FactoryGirl.define do
  factory :user, aliases: [:author] do

    name "Foo0"

    email { "#{name}@bar.com" }

    password "foobar"

  end
end