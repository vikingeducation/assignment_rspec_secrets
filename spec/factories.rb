FactoryGirl.define do

  factory :user, aliases: [:author] do
    sequence(:name){ |n| "name#{n}"}
    email {"#{name}@email.com"}
    password 'foobar'
  end

  factory :secret do
    title "super dope title"
    body "super dope body"
    author
  end

end