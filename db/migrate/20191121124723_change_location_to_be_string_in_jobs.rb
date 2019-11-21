class ChangeLocationToBeStringInJobs < ActiveRecord::Migration[5.2]
  def change
    change_column :jobs, :location, :string
  end
end
