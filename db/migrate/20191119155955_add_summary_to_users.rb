class AddSummaryToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :summary, :text
  end
end
