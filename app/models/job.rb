class Job < ApplicationRecord
  belongs_to :user
  has_many :shifts
  has_many :reviews, through: :shifts
  include PgSearch::Model
  pg_search_scope :kinda_matching,
                  against: :title,
                  using: {
                    tsearch: { dictionary: "english" }
                  }
end
