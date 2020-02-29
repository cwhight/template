class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :shift
  belongs_to :request
end
