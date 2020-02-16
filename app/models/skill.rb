class Skill < ApplicationRecord
  has_many :users, through: :skills_joiners
end
