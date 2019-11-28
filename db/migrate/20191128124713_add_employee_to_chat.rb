class AddEmployeeToChat < ActiveRecord::Migration[5.2]
  def change
    add_reference :chats, :employee, foreign_key: {to_table: :users}
  end
end
