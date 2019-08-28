class CreateSpeakers < ActiveRecord::Migration[5.2]
  def change
    create_table :speakers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.integer :congregation_id
      t.timestamps
    end
  end
end
