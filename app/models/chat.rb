class Chat < ApplicationRecord
  belongs_to :request
  belongs_to :employer, class_name: "User"
  belongs_to :employee, class_name: "User"
  has_many :messages
end
