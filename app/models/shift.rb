class Shift < ApplicationRecord
  include ActiveModel::Validations
  belongs_to :user, optional: true
  belongs_to :job
  has_many :reviews
  has_many :requests
  validates_associated :job
  validates :pay, presence: true, numericality: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_time_before_end_time
  validate :start_time_in_future
  validates :price_cents, presence: true, numericality: true
  monetize :price_cents

  def start_time_before_end_time
    if end_time < start_time
      errors.add(:end_time, "can't be before start time")
    end
  end

  def start_time_in_future
    if start_time < Time.zone.now
      errors.add(:start_time, "can't be in the past")
    end
  end
end
