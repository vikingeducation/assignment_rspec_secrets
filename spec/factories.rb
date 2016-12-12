FactoryGirl.define do 

  factory :secret do
    title "Secret Title!"
    body "This is the body of this secret!"
    author
  end

  factory :user, aliases: [:author] do
    name "Person McPerson"
    email "email@email.com"
    password "foobar123"
  end

end