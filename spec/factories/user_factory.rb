FactoryGirl.define do

  factory :user, aliases: [:author] do
    name "Foobar"
    sequence(:email) { |n| "Foobar@email#{n}.com" }
    password "foobar"
  end

end
