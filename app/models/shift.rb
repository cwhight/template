class Shift < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :job
  has_many :reviews
  has_many :requests
  validates :pay, presence: true, numericality: true
end
