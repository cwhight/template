class AddEmployerToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :employer, :boolean, default: false
  end
end
