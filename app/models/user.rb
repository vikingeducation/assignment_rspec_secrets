class User < ApplicationRecord

  has_secure_password

  has_many :secrets, :foreign_key => :author_id

  validates :name, :email, :presence => true
  validates :name, :length => { :in => 3..20 }
  validates :email, :uniqueness => true
  validates :password,
            :length => { :in => 6..16 }
end
