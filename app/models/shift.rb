class Shift < ApplicationRecord
  belongs_to :user
  belongs_to :job
  has_many :reviews
end
