FactoryGirl.define do
  factory :user, :aliases => [:author] do
    name    "Derp"
    email   "Derpy@gmail.com"
    password_digest   "foobar"
    password "foobar"
  end

end