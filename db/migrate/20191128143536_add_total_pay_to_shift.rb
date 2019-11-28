class AddTotalPayToShift < ActiveRecord::Migration[5.2]
  def change
    add_column :shifts, :total_pay, :integer
  end
end
