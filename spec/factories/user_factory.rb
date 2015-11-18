FactoryGirl.define do
  factory :user, :aliases => [:author] do
    sequence(:name) {|n| "Mr. Potato Head - #{n}"}
    sequence(:email) {|n| "mr-#{n}@potato.head"}
    password 'password'
  end
end