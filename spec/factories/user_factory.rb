FactoryGirl.define do
  sequence(:name) do |n|
    "name#{n}"
  end

  factory :user do
    name
    email {"#{name}@sample.com"}
    password "foobar"
  end

end
