class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shift
  validates :title, presence: true, length: { in: 3..20 }
  validates :score, presence: true, numericality: true, inclusion: { in: [1, 2, 3, 4, 5] }
  validates :content, presence: true, length: { maximum: 500 }
end
