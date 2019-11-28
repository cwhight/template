class RemoveUserFromChat < ActiveRecord::Migration[5.2]
  def change
    remove_reference :chats, :user, foreign_key: true
  end
end
