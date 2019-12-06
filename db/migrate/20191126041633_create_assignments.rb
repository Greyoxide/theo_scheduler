class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.references :person, foreign_key: true
      t.integer :kind
      t.date :date

      t.timestamps
    end
  end
end
