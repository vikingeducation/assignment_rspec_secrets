# spec/factories.rb

FactoryGirl.define do

  factory :user, aliases: [:author] do
    first_name = "Foo"
    last_name = "Bar"

    sequence(:name) do |n|
      "#{first_name} #{last_name} #{n}"
    end

    sequence(:email) do |n|
      "#{first_name}.#{n}@bar.com".downcase
    end

    password "foobar"
    password_confirmation "foobar"

  end

  factory :secret do
    title "This is a secret"
    body "A very, very secret secret. Shhhh."

    author
  end

end
