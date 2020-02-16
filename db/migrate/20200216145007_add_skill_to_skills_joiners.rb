class AddSkillToSkillsJoiners < ActiveRecord::Migration[5.2]
  def change
    add_reference :skills_joiners, :skill, foreign_key: true
  end
end
