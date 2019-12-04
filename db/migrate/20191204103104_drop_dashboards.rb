class DropDashboards < ActiveRecord::Migration[5.2]
  def change
    drop_table :dashboards
  end
end
