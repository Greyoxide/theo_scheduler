class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.date :password_reset_sent_at
      t.string :password_reset_token
      t.string :secure_token

      t.timestamps
    end
  end
end
