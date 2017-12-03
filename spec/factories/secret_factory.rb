FactoryGirl.define do

  sequence(:title) do |n|
    "Test message #{n}"         
  end

  sequence(:body) do |n|
    "Test body #{n}"         
  end


  factory :secret do
    title 
    body  
    author
  end
end


