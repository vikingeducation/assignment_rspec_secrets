# spec/factories.rb
FactoryGirl.define do
  # A block defining the attributes of a model
  # The symbol is how you will later call it
  # Factory Girl assumes that your class name
  # is the same as the symbol you passed
  # (so here, it assumes this is a User)
  factory :user, :aliases => [:author] do
    sequence(:name)  {|n| "Foo#{n}" }
    sequence(:email)  {|n| "foo#{n}@bar.com" }
    password "foobar"
    password_confirmation "foobar"
  end

  # This factory will allow you to call it
  # using the `:admin` key.  Because FG 
  # assumes this is an `Admin` model, you'll
  # need to specify that it's actually a User
  factory :secret do
    sequence(:title) { |n| "secret #{n}"}
    sequence(:body) { |n| "secret body #{n}"}
    author
  end

end