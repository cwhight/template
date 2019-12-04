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

  def self.upcoming_shifts_to_json(user_id)
    user = User.find(user_id)
    upcoming_shifts_json = []
    return unless user.employer == false

    user.shifts.select { |shift| shift.start_time >= DateTime.now }.each do |shift|
      upcoming_shift_json = {
        title: shift.title,
        start: shift.start_time.delete_suffix(' +0000'),
        end: shift.end_time.delete_suffix(' +0000')
      }

      upcoming_shifts_json << upcoming_shift_json

    end
    return upcoming_shifts_json
  end

  def self.past_shifts_to_json(user_id)
    user = User.find(user_id)
    past_shifts_json = []
    return unless user.employer == false

    user.shifts.select { |shift| shift.start_time <= DateTime.now }.each do |shift|
      past_shift_json = {
        title: shift.title,
        start: shift.start_time.delete_suffix(' +0000'),
        end: shift.end_time.delete_suffix(' +0000')
      }

      past_shifts_json << past_shift_json

    end
    return past_shifts_json
  end

  def self.pending_shifts_to_json(user_id)
    user = User.find(user_id)
    pending_shifts_json = []
    return unless user.employer == false

    applied_shifts = []
    user.requests.each { |request| applied_shifts << request.shift unless request.shift.user }

    applied_shifts.each do |shift|
      pending_shift_json = {
        title: "#{shift.title} (pending)",
        start: shift.start_time.delete_suffix(' +0000'),
        end: shift.end_time.delete_suffix(' +0000')
      }

      pending_shifts_json << pending_shift_json
    end
    return pending_shifts_json
  end
end
