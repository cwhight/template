class AddVenueToJob < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :venue, :string
  end
end
