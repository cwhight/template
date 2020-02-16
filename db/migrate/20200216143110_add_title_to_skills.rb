class AddTitleToSkills < ActiveRecord::Migration[5.2]
  def change
    add_column :skills, :title, :string
  end
end
