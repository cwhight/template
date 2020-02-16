class AddSkillsToSkillsJoiners < ActiveRecord::Migration[5.2]
  def change
    add_reference :skills_joiners, :skills, foreign_key: true
  end
end
