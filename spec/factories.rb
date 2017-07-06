FactoryGirl.define do

  factory :user, :aliases => [:author] do
    name "Marek"
    sequence(:email) { |n| "#{name}_#{n}@factory.com" }
    # email { "#{name}@gmail.com" }
    password_digest "loko12"
  end

  factory :secret do
    title "Hey, This is  my title"
    body "Hey, This is my body"
    author
  end
end
