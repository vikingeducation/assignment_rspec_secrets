FactoryGirl.define do

  factory :user do
    sequence(:name) { |n| "Foo#{n}" }
    email { "#{name}@bar.com" }
    password "foobar"
    password_confirmation "foobar"
  end



end
