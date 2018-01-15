FactoryBot.define do

  factory :user, aliases: [:author] do
    sequence(:name){ |n| "FooName_#{n}"}
    email { "#{name}@email.com" }
    password 'password'
  end

end
