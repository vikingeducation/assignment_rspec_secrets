FactoryGirl.define do
  factory :user, aliases: [:author] do
    sequence(:name){|n| "foo#{n}"}
    email {"#{name}@bar.com"}
    password {"foobar"}
    password_confirmation {"foobar"}
  end

  factory :secret do
    title {"foobar"}
    body {"secret foo"}
    author
  end

end

