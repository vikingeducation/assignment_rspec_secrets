FactoryGirl.define do

  factory :user, aliases: [:author] do
    name "Bob"
    email "bob@gmail.com"
    password "bob123"
  end

  factor :secret do
    title "Secret Title"
    body "This is a secret body."
    author
  end

end