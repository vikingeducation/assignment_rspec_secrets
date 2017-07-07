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
    author


    # trait :frequent_author do
    #   after_build do |user|
    #     create_list( :post, 5, author: user )
    #   end
    # end

    # trait :recent do
    #   created_at { Time.now }
    # end
    #
    # trait :old do
    #   created_at { 1.week.ago }
    # end

  end


end
