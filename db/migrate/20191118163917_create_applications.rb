class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.references :user, foreign_key: true
      t.references :shift, foreign_key: true
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
