class Job < ApplicationRecord
  belongs_to :user
  has_many :shifts
  has_many :reviews, through: :shifts
  validates :title, presence: true, length: { in: 2..30 }
  validates :description, presence: true, length: { maximum: 200 }
  validates :location, presence: true
  include PgSearch::Model
  pg_search_scope :kinda_matching,
                  against: :title,
                  using: {
                    tsearch: { dictionary: "english" }
                  }
end
