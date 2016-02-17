FactoryGirl.define do

  factory :user, aliases: [:author] do
    name "Username"
    sequence(:email) { |n| "foo#{n}@bar.com"}
    password "foobar"
  end

  factory :duplicate_email, class: :user do
    name "Username"
    email "foo1@bar.com"
    password "foobar"
  end




  factory :secret do
    title "Secret title"
    body "Secret body"

    author        # will call factory method above
                    #doesn't have to be build
  end


  factory :multiple_secrets, class: :secret do
    sequence(:title) { |n| "Secret title#{n}" }
    sequence(:body) { |n| "Secret body#{n} lorem ipsum" }
    
    author  
  end

end