class AddEndTimeToShifts < ActiveRecord::Migration[5.2]
  def change
    add_column :shifts, :end_time, :string
  end
end
