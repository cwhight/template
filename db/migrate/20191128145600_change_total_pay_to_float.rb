class ChangeTotalPayToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :shifts, :total_pay, :float
  end
end
