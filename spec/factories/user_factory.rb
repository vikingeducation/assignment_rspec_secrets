FactoryGirl.define do
<<<<<<< HEAD
  factory :user, aliases: [:author] do
    sequence(:name) { |n| "pokemon#{n}"}
    email { "#{name}@email.com" }
    password "foobar"
    password_confirmation "foobar"
  end
end
=======

  factory :user, aliases: [:author] do
    sequence(:name) { |n| "Foo#{n}" }
    email { "#{name}@bar.com" }
    password "foobar"
    password_confirmation "foobar"
  end



end
>>>>>>> 51eac85445bb119f6b889bafe978b30664ff9edd
