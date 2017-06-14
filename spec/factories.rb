FactoryGirl.define do

  factory :user, aliases: [:author] do
    sequence(:name){ |n| "Foo#{n}"}
    email { "#{name}@bar.com".downcase }
    password "foobar"
    password_confirmation "foobar"
  end

  factory :secret do
    title { "#{author.name} title" }
    body { "#{author.name} body" }
    author
  end

end
