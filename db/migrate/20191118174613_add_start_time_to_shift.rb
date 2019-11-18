class AddStartTimeToShift < ActiveRecord::Migration[5.2]
  def change
    add_column :shifts, :start_time, :time
    add_column :shifts, :end_time, :time
  end
end
