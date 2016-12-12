FactoryGirl.define do

  factory :secret do
    title "Secret Title!"
    body "This is the body of this secret!"
    author
  end

  factory :user, aliases: [:author] do
    sequence(:name){ |n| "Foo#{n}"}

    # Don't forget to pass a BLOCK if you
    #   are interpolating dynamic values:
    email { "#{name}@bar.com" }

    password "foobar123"
  end

end
