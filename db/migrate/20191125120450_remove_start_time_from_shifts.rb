class RemoveStartTimeFromShifts < ActiveRecord::Migration[5.2]
  def change
    remove_column :shifts, :start_time, :time
  end
end
