FactoryGirl.define do

  factory :user, :aliases => [:author] do
    sequence(:name){ |n| "Marek#{n}"}
    sequence(:email) { |n| "#{name}_#{n}@factory.com" }
    # email { "#{name}@gmail.com" }
    password "loko12"

    # trait :frequent_author do
    #   after_build do |user|
    #     create_list( :secret, 5, author: user )
    #   end
    # end

  end

  factory :secret do
    sequence(:title){ |n| "Hey, my title - #{n}"}
    sequence(:body){ |n| "Hey, my new body - #{n}"}
    author

  end


end
