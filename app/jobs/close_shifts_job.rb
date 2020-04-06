# class CloseShiftsJob < ApplicationJob
#   queue_as :default

#   def perform
#     # Do something later
#     Shift.all.each do |shift|
#       if Time.parse(shift.start_time) < DateTime.now
#         shift.update_attribute(:completed, true)
#         shift.requests.each { |request| request.update_attribute(:completed, true) }
#       end
#     end
#   end
# end
