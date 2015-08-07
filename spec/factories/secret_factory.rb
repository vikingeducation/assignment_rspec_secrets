FactoryGirl.define do

  factory :secret do
    title "Foo Post"
    body "This is super foo"

    author
  end
end
