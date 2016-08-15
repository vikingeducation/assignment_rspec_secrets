FactoryGirl.define do

  factory :user do
    name        "Foo"
    email       "foofoo@bar.com"
    password    "foobar"
  end

  factory :secret do
    title "secret title"
    body  "pssssssssssst"
  end

end