class AddCompletedToShifts < ActiveRecord::Migration[5.2]
  def change
    add_column :shifts, :completed, :boolean
  end
end
