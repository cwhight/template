class AddRequestToChat < ActiveRecord::Migration[5.2]
  def change
    add_reference :chats, :request, foreign_key: true
  end
end
