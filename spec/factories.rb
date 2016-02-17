FactoryGirl.define do


  factory :user, aliases: [:author] do
    name "Foobar"
    email { "#{name}@example.com" }
    password "qwerqwer"
  end

  factory :secret do
    sequence(:title){ |n| "Title#{n}" }
    body { "this is a body sentence #{title}" }
    author
  end


end
