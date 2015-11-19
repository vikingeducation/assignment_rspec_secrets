FactoryGirl.define do
  factory :secret do
    sequence(:title) {|n| "Secret - #{n}"}
    body 'I know what you did last summer!'
    author
  end
end