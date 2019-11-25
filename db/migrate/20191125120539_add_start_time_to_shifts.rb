class AddStartTimeToShifts < ActiveRecord::Migration[5.2]
  def change
    add_column :shifts, :start_time, :string
  end
end
