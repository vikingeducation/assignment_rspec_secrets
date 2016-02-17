FactoryGirl.define do

  factory :user, aliases: [:author] do
    name "Username"
    sequence(:email) { |n| "foo#{n}@bar.com"}
    password "foobar"
  end




  factory :secret do
    title "Secret title"
    body "Secret body"

    author
  end







end