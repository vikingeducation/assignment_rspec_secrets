FactoryGirl.define do

  factory :secret do
    title "Secret Title!"
    body "This is the body of this secret!"
    author
  end

  factory :user, aliases: [:author] do
    sequence(:name){ |n| "Foo#{n}"}
    email { "#{name}@bar.com" }
    password "foobar123"
  end

end
