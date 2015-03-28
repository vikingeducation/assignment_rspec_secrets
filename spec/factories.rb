FactoryGirl.define do


  factory :user, aliases: [:author] do
    name "schwaddy"
    email "schwad@schwad.com"
    password "foobar"
  end

  factory :secret do
    title "foo"
    body  "bar"
    author
  end

end