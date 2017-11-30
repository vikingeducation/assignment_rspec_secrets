FactoryGirl.define do
  factory :user do
    name        "Foo"
    email       "foo@bar.com"
    password    "foobar"
  end

  factory :secret do
    title   "Test message!"
    body    "Test body"
    author  "foo"
  end
end
