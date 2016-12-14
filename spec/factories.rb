FactoryGirl.define do

  factory :user, aliases: [:author] do
    sequence(:name){ |n| "Foo#{n}"}
    email { "#{name}@example.com" }
    password "asdfasdf"
  end

  factory :secret do
    title "test"
    body "body"
    association :author, factory: :user
  end


end

#
# class Secret < ApplicationRecord
#
#   belongs_to :author, :class_name => "User"
#
#   validates :title, :body, :author, :presence => true
#   validates :title, :length => { :in => 4..24 }
#   validates :body, :length => { :in => 4..140 }
#
#
#   def self.last_five
#     order(id: :desc).limit(5)
#   end
# end

# class User < ApplicationRecord
#
#   has_secure_password
#
#   has_many :secrets, :foreign_key => :author_id
#
#   validates :name, :email, :presence => true
#   validates :name, :length => { :in => 3..20 }
#   validates :email, :uniqueness => true
#   validates :password,
#             :length => { :in => 6..16 },
#             :allow_nil => true
# end
