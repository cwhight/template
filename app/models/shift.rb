class Shift < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :job
  has_many :reviews
  has_many :requests
  validates :price_cents, presence: true, numericality: true
  monetize :price_cents
end
