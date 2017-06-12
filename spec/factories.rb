FactoryGirl.define do

  factory :user, aliases: [:author] do
    sequence(:name){ |n| "Foo#{n}"}
    email { "#{name}@bar.com"}
    password "foobar"
    password_confirmation "foobar"
  end

  factory :secret do
    title "a title"
    body "a body"
    author
  end

end
