FactoryGirl.define do

  factory :user do
    name  "Foo Bar"
    email "foo@bar.com"
    password "foobar"
  end

  factory :user_with_no_password, :class => :user do
    name  "No Password"
    email "nopasword@aol.com"
  end

end

  