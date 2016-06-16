FactoryGirl.define do

  factory :user, aliases: [:author] do
    sequence( :name ) { |n| "Test_user#{n}" }
    email { "#{name}@email.com" }
    password "foobarfoobar"
  end

  factory :secret do
    title "I'm a secret title"
    body "I'm a secret body"
    author
  end

end