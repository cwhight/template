class RemoveMessageFromChat < ActiveRecord::Migration[5.2]
  def change
    remove_column :chats, :message, :text
  end
end
