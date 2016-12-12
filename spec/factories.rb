FactoryGirl.define do

  factory :user do
    sequence(:name) do |n|
      "foo#{n}"
    end

    email {"#{name}@bar.com"}
    password "foobar"
  end

  factory :secrets do
    sequence(:title) do |n|
      "This is the #{n} secret"
    end
    body "This is a scandalous, juicy secret. Oh my!"
  end
end
