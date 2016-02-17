FactoryGirl.define do

  factory :user, :aliases => [:author] do
    name  "Foo Bar"
    email "foo@bar.com"
    password "foobar"

    #sequence(:email){ |n| "#{n}@aol.com"}

  end

  factory :user_with_no_password, :class => :user do
    name  "No Password"
    email "nopasword@aol.com"
  end

  factory :secret do
    title "Title Secret"
    body  "This is the body of the secret."
    author

    # sequence an attribute to uptick with each
    # new build of the user
    #sequence(:title){ |n| "#{n}"}
    #sequence(:body){ |n| "10*#{n}"}

  end

end

  