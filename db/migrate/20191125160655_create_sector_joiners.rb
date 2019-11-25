class CreateSectorJoiners < ActiveRecord::Migration[5.2]
  def change
    create_table :sector_joiners do |t|
      t.references :job, foreign_key: true
      t.references :sector, foreign_key: true

      t.timestamps
    end
  end
end
