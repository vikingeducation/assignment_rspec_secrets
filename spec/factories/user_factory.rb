FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "pokemon#{n}"}
    email { "#{name}@email.com" }
    password "foobar"
    password_confirmation "foobar"
  end
end