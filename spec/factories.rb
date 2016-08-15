FactoryGirl.define do

  factory :user do
    trait :with_attributes do
      name "Mike"
      email "mike@gmail.com"
      password "asdfasdf"
    end

    trait :without_attributes do
    end

  end

end