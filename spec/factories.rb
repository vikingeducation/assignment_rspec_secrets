FactoryGirl.define do
  factory :user, aliases: [:author] do
    sequence(:name){ |n| "Foo#{n}"}
    email { "#{name}@bar.com" }
    password 'foobar'
  end

  factory :secret do
    sequence(:title){ |n| "A New Title #{n}"}
    body 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellendus, molestiae?'
    author


  end



end
