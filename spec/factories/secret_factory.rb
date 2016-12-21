FactoryGirl.define do
  factory :secret do
    title    "Foo Article"
    body     "Lorem Ipsum text"
    association :author, factory: :user
  end

end