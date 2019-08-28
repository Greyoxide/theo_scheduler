class CreateCongregations < ActiveRecord::Migration[5.2]
  def change
    create_table :congregations do |t|
      t.string :name
      t.boolean :home
      t.string :coordinator
      t.string :coordinator_phone
      t.timestamps
    end
  end
end
