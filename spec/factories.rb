FactoryGirl.define do

  factory :user, aliases: [:author] do
    sequence(:name) {|n| "Foo#{n}"}
    email {"#{name}@bar.com"}
    password "password"

    factory :user_with_secret do
      after(:create) do |user|
        create(:secret, author_id: user.id)
      end
    end
  end

  factory :secret do
    title "New title"
    body "Lorem ipsum"
    author

    factory :invalid_secret do
      title nil
    end
  end
end