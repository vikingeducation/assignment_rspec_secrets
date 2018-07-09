FactoryGirl.define do

  factory :user, aliases: [:author] do
    sequence(:name) { |n| "Person#{n}"}
    email {"#{name}@yahoo.com".downcase}
    password "password"
  end

  factory :secret do
    author
    title "Awesome Title"
    body "This is a body all about the title"
  end


end
