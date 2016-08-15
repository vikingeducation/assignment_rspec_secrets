FactoryGirl.define do
  factory :user, aliases: [:author] do
    sequence(:name) { |n| "pokemon#{n}"}
    email { "#{name}@email.com" }
    password "foobar"
    password_confirmation "foobar"
  end
end