class Job < ApplicationRecord
  belongs_to :user
  has_many :shifts, dependent: :destroy
  has_many :reviews, through: :shifts

  validates :title, presence: true, length: { in: 2..100 }
  validates :description, presence: true, length: { maximum: 200 }
  validates :location, presence: true

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  include PgSearch::Model
  pg_search_scope :kinda_matching,
                  against: :title,
                  using: {
                    tsearch: { dictionary: "english" }
                  }
end
