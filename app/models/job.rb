class Job < ApplicationRecord
  belongs_to :user
  has_many :favourites
  has_many :sector_joiners
  has_many :sectors, through: :sector_joiners
  has_many :shifts, dependent: :destroy
  has_many :reviews, through: :shifts

  validates :title, presence: true, length: { in: 2..100 }
  validates :description, presence: true, length: { maximum: 200 }
  validates :location, presence: true

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  scope :search_by_sector, ->(ids) { joins(:sector_joiners).merge(SectorJoiner.where(sector_id: ids.map(&:to_i))) }
  include PgSearch::Model
  pg_search_scope :kinda_matching,
                  against: :title,
                  using: {
                    tsearch: { dictionary: "english" }
                  }

  def relevant_shifts(min_price, max_price, lower_start_date, higher_start_date)
    if min_price && lower_start_date
      new_shifts = shifts.reject { |shift| (shift.start_time < lower_start_date) || (shift.start_time > higher_start_date) }.reject { |shift| (shift.price_cents < min_price) || (shift.price_cents > max_price) }
    elsif min_price
      new_shifts = shifts.reject { |shift| (shift.price_cents < min_price) || (shift.price_cents > max_price) }
    elsif lower_start_date
      new_shifts = shifts.reject { |shift| (shift.start_time < lower_start_date) || (shift.start_time > higher_start_date) }
    else
      new_shifts = shifts
    end

    new_shifts.reject { |shift| shift.completed || shift.user || Time.parse(shift.start_time) < Time.now }
  end

end
