FactoryGirl.define do
  factory :user, :aliases => [:author] do
    # sequence(:name){ |n| "Foo#{n}"}
    name "Foo"
    sequence(:email) { |n| "#{n}@exaxmple.com" }
    password "foobar"
    password_confirmation "foobar"
  end

  factory :secret do
    sequence(:title) do |n|
      "foo#{n}" # e.g. "foo312"
    end
    body "body"

    #assocation with user 1:X
    author
  end
end
