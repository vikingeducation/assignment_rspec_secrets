FactoryGirl.define do


  factory :user, aliases: [:author] do
    name "Foobar"
    email { "#{name}@example.com" }
    password "qwerqwer"
  end

  factory :secret do
    title "title"
    body "this is a body sentence"
    author
  end


end
