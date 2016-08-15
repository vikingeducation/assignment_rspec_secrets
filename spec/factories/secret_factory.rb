FactoryGirl.define do

  factory :secret do
    sequence(:title) { |n| "Secret_title#{n}" }
    body "Please don't tell"

    association :author, factory: :user
  end

end
