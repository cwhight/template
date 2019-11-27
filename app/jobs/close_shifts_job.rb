class CloseShiftsJob < ApplicationJob
  queue_as :default

  def perform
    # Do something later
    Shift.all.each do |shift|
      if Time.parse(shift.end_time) < DateTime.now
        shift.update_attribute(:completed, true)
      end
    end
  end
end
