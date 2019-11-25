class RemoveDateFromShifts < ActiveRecord::Migration[5.2]
  def change
    remove_column :shifts, :date, :date
  end
end
