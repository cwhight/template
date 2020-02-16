class CreateSkillsJoiners < ActiveRecord::Migration[5.2]
  def change
    create_table :skills_joiners do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
