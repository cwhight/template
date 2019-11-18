class AddDateToShift < ActiveRecord::Migration[5.2]
  def change
    add_column :shifts, :date, :date
  end
end
