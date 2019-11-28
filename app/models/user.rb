class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :jobs
  has_many :reviews, dependent: :destroy
  has_many :requests
  has_many :shifts

  has_many :messages
  has_many :chats, foreign_key: "employer_id"
  has_many :employee_chats, foreign_key: "employee_id", class_name: "Chat"

  has_many :orders

  has_one_attached :photo
  validates :terms_of_service, acceptance: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
