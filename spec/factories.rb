FactoryGirl.define do


  factory :user, aliases: [:author] do
    name "foobar"
    email {"#{name}@example.com"}
    #sequence(:email) { |n| "#{name}@example.com"}
    password "qwerqwer"

    trait :wrong_password do
      email "foobar@example.com"
      password "123456"
    end

    trait :wrong_email do
      email "1234@1234.com"
    end
  end

  factory :secret do
    sequence(:title){ |n| "Title#{n}" }
    body { "this is a body sentence #{title}" }
    author
  end


end
