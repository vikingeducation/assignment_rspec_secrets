FactoryBot.define do

  factory :user, aliases: [:author] do
    name 'FooName'
    email { "#{name}@email.com" }
    password 'password'
  end

  factory :secret do
    title 'foo secret title'
    body 'foo secret body'
    author
  end

end
