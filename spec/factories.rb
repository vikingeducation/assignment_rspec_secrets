FactoryGirl.define do

  factory :user do
    name "Marek"
    email { "#{name}@gmail.com" }
    password_digest "loko12"
  end

  factory :secret do
    title "Hey, This is  my title"
    body "Hey, This is my body"
  end
end
