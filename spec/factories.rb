FactoryGirl.define do
  factory :user, :aliases => [:author] do
    sequence(:name) { |n| "Steven_Chang#{n}" }
    email           { "#{name}@hotmail.com" }
    password          "clamocop"
  end

  factory :secret do
    title    "Julian Casa Blanks?"
    body     "But you thought I would look the other way..."

    author
  end
end