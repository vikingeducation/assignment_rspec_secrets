FactoryGirl.define do
  factory :user, :aliases => [:author] do
    name "Foo"
    email { "#{name}@exaxmple.com" }
    password "foobar"
    password_confirmation "foobar"
    
  end

  factory :secret do
    title "Title"
    body "body"

    #assocation with user 1:X
    author
  end
end
