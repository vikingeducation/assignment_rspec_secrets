FactoryGirl.define do
<<<<<<< HEAD
  factory :secret do
    author
    sequence(:title) { |n| "title#{n}"}
    sequence(:body) { |n| "body#{n}"}


  end
end
=======

  factory :secret do
    title "Secret Title"
    body  "Secret Body"
    author
  end

end
>>>>>>> 51eac85445bb119f6b889bafe978b30664ff9edd
