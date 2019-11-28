class AddEmployerToChat < ActiveRecord::Migration[5.2]
  def change
    add_reference :chats, :employer, foreign_key: {to_table: :users}
  end
end
