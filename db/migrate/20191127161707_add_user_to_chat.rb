class AddUserToChat < ActiveRecord::Migration[5.2]
  def change
    add_reference :chats, :user, foreign_key: true
  end
end
