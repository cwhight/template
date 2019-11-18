class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :description
      t.text :location

      t.timestamps
    end
  end
end
