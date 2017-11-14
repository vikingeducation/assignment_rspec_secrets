FactoryGirl.define do
  sequence(:title) do |n|
    "title#{n}"
  end

  sequence(:body) do |n|
    "body#{n}"
  end

  sequence(:author_id) do |n|
    n
  end
  
  factory :secret do
    title
    body
    author_id
  end

end
