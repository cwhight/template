class Shift < ApplicationRecord
  include ActiveModel::Validations
  belongs_to :user, optional: true
  belongs_to :job
  has_one :order
  has_many :reviews
  has_many :requests
  validates_associated :job
  validates :price, presence: true, numericality: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_time_before_end_time
  validate :start_time_in_future
  validates :price_cents, presence: true, numericality: true
  monetize :price_cents
  after_create :total_pay
  after_update :total_pay
  has_many :offers

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

  def total_pay
    total_pay = ((price.fractional.to_f / 100) * ((Time.parse(end_time) - Time.parse(start_time)) / 3600))
  end
end
