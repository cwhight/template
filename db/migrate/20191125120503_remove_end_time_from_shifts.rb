class RemoveEndTimeFromShifts < ActiveRecord::Migration[5.2]
  def change
    remove_column :shifts, :end_time, :time
  end
end
