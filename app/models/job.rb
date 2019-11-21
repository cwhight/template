class Job < ApplicationRecord
  belongs_to :user
  has_many :shifts
  has_many :reviews, through: :shifts
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

end
