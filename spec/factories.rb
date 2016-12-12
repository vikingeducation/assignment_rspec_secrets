FactoryGirl.define do

  factory :user, aliases: [:author] do
    sequence(:name) do |n|
      "foo#{n}"
    end

    email {"#{name}@bar.com"}
    password "foobar"
  end

  factory :secret do
    sequence(:title) do |n|
      "This is the #{n} secret"
    end
    body "This is a scandalous, juicy secret. Oh my!"
    author
  end
end
