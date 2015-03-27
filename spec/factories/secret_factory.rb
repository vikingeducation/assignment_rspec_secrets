FactoryGirl.define do
  factory :secret do
    title   "Hello world!"
    body    "Lorem ipsum"

    author
  end
end