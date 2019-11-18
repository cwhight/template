class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.string :title
      t.integer :pay
      t.date :start_time
      t.date :end_time
      t.references :user, foreign_key: true
      t.references :job, foreign_key: true
      t.references :review, foreign_key: true

      t.timestamps
    end
  end
end
