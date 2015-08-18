FactoryGirl.define do
 

  # User factory
  factory :user, aliases: [:author] do
    name                    "Foo"
    sequence(:email){ |n|   "foo#{n}@bar.com" }
    password                "password"
    password_confirmation   "password"

    factory :user_with_secret do
      after(:create) do |user|
        create(:secret, author_id: user.id)
      end
    end

  end


  factory :secret do
    title         "Foo Title"
    body       "Look at this secret!"
    author_id     "22"
    author
  end


end