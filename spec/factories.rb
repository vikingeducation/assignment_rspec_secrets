FactoryGirl.define do
  factory :user, aliases: [:author] do
    sequence  (:name){|n| "foobar#{n}" }
    email     { "#{name}@email.com" }
    password  "foofoobar"
  end

  factory :secret do
    title    "Foo Article"
    body     "Lorem Ipsum text"
    author
  end
end
