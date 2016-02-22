FactoryGirl.define do
  factory :user, aliases: [:author] do
    sequence(:name){ |n| "Foo#{n}" }
    email { "#{name}@bar.com" }
    password "foobar"
  end

  factory :invalid_user, parent: :user do
    email nil
  end
end