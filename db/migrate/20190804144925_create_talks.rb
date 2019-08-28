class CreateTalks < ActiveRecord::Migration[5.2]
  def change
    create_table :talks do |t|
      t.date :date
      t.references :speaker, foreign_key: true
      t.references :outline, foreign_key: true
      t.integer :congregation_id, foreign_key: true
      t.integer :group_id, foreign_key: true

      t.timestamps
    end
  end
end
