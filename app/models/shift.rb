class Shift < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :job
  has_many :reviews
  has_many :applications
end
