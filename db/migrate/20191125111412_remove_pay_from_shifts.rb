class RemovePayFromShifts < ActiveRecord::Migration[5.2]
  def change
    remove_column :shifts, :pay, :integer
  end
end
