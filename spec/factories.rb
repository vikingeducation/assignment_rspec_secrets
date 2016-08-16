FactoryGirl.define do

  factory :user do
    name        "Foo"
    sequence :email do |n|
      "foofoo#{n}@bar.com"
    end
    password    "foobar"
  end

  factory :secret do
    title "secret title"
    body  "pssssssssssst"
    # association :user, factory: :user
  end

end