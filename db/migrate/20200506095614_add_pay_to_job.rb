class AddPayToJob < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :pay, :float
  end
end
