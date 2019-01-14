class Project < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :commenters, through: :comments, source: :user
  

  validates :name, presence: true

end
