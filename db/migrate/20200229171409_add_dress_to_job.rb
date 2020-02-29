class AddDressToJob < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :dress, :text
  end
end
