FactoryGirl.define do


  factory :user, aliases: [:author] do
    name "schwaddy"
    email "schwad@schwad.com"
    password "foobar"
  end

  factory :secret do
    title "foooooo"
    body  "barrrrrr"
    author
  end

end