FactoryGirl.define do 
  factory :user do 
    name
    email "#{name}@bar.com"
  end

  factory :secrets do 
    title 
    body "This is a scandalous, juicy secret. Oh my!"
  end

  sequence(:name) do |n|
    "foo#{n}"
  end

  sequence(:title) do |n|
    "This is the #{n} secret"
  end

end