FactoryGirl.define do
  factory :user, aliases: [:author] do
    sequence(:name){ |n| "Foo#{n}" }
    email { "#{name}@bar.com" }
    password "foobar"
  end
end