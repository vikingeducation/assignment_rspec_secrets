FactoryGirl.define do 
  factory :user, aliases: [:author] do 
    name "Foobar"
    email { Faker::Internet.safe_email }
    password "password"
    password_confirmation "password"
  end

  factory :user2 do
    name "foo"
    email "email@email.com"
    password "password"
    password_confirmation "password"

  end

  factory :user3 do 
    name "foo"
    email "email@email.com"
    password "password"
    password_confirmation "password"
  end

  factory :a_user_has_no_name do 
    
    email Faker::Internet.safe_email
    password "password"
    password_confirmation "password"
  end



end