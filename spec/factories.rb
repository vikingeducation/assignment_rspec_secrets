FactoryGirl.define do

  factory :user, aliases: [:author] do
    name "Username"
    sequence(:email) { |n| "foo#{n}@bar.com"}
    password "foobar"
  end


  factory :secret do
    title "Secret title"
    body "Secret body"

    author        # will call factory method above
                    #doesn't have toi be build
  end

  factory :secret_wo_title, class: :secret do
    body "Secret body"
    author       
  end

  factory :secret_wo_body, class: :secret do
    title "Secret body"
    author 
  end

  factory :multiple_secrets, class: :secret do
    sequence(:title) { |n| "Secret title#{n}" }
    sequence(:body) { |n| "Secret body#{n} lorem ipsum" }
    
    author  
  end

end