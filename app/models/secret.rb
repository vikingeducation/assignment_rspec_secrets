class Secret < ActiveRecord::Base

  belongs_to :author, :class_name => "User"

  validates :title, :body, :author, :presence => true
  validates :title, :length => { :in => 4..24 }
  validates :body, :length => { :in => 4..140 }


  def self.last_five
    limit(5).order(created_at: :desc)
  end
end
