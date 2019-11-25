class Sector < ApplicationRecord
  has_many :jobs, through: :sector_joiner
end
