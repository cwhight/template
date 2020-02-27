class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shift
  belongs_to :reviewer,  class_name: "User"
  validates :title, presence: true, length: { in: 3..50, too_long: "%{count} characters is the maximum allowed" }
  validates :score, presence: true, numericality: true, inclusion: { in: [1, 2, 3, 4, 5] }
  validates :content, presence: true, length: { maximum: 500 }
end
