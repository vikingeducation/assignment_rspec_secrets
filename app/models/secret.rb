class Secret < ApplicationRecord

  belongs_to :author, :class_name => "User"

  validates :title, :body, :author, :presence => true, :uniqueness => true
  validates :title, :length => { :in => 4..24 }, :uniqueness => true
  validates :body, :length => { :in => 4..140 }


  def self.last_five
    order(id: :desc).limit(5)
  end
end
