FactoryGirl.define do
  factory :user, :aliases => [:author] do
    sequence(:name) {|n| "Mr. Magoo #{n}"}
    sequence(:email) {|n| "mr-#{n}@potato.head"}
    password 'password'
  end
end