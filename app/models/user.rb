class User < ApplicationRecord

  has_secure_password

  has_many :secrets, :foreign_key => :author_id

  validates :name, :email, :presence => true
  validates :name, :length => { :in => 3..20 }, :uniqueness => true
  validates :email, :uniqueness => true, format: { with: /@/}
  validates :password,
            :length => { :in => 6..16 },
            :allow_nil => true
end
