class AddCompletedToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :completed, :boolean
  end
end
