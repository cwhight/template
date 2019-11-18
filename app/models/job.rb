class Job < ApplicationRecord
  belongs_to :user
  has_many :shifts
  has_many :reviews, through: :shifts

end
