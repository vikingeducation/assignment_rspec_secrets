class User < ActiveRecord::Base

  has_secure_password

  has_many :secrets, :foreign_key => :author_id

  validates :name, :email, :presence => true
  validates :name, :length => { :in => 3..20 }
  validates :email, :uniqueness => true, format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :password,
            :length => { :in => 6..16 },
            :allow_nil => true
end
