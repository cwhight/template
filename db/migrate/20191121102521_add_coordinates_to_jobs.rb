class AddCoordinatesToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :latitude, :float
    add_column :jobs, :longitude, :float
  end
end
