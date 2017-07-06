FactoryGirl.define do

  factory :user, :aliases => [:author] do
    sequence(:name){ |n| "Marek#{n}"}
    sequence(:email) { |n| "#{name}_#{n}@factory.com" }
    # email { "#{name}@gmail.com" }
    password "loko12"
  end

  factory :secret do
    sequence(:title){ |n| "Hey, my title - #{n}"}
    sequence(:body){ |n| "Hey, my new body - #{n}"}
    # title "Hey, This is  my title"
    # body "Hey, This is my body"
    author

    # association :author, :factory => :user
  end


end
