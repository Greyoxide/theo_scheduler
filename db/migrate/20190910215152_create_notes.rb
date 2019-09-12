class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :notable_type
      t.integer :notable_id
      t.text :body

      t.timestamps
    end
  end
end
