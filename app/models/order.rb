class Order < ApplicationRecord
  belongs_to :user
  belongs_to :shift
  monetize :amount_cents
end
