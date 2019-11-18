class RemoveStartTimeFromShift < ActiveRecord::Migration[5.2]
  def change
    remove_column :shifts, :start_time, :string
    remove_column :shifts, :end_time, :string
  end
end
