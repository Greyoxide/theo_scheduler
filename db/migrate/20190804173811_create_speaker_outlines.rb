class CreateSpeakerOutlines < ActiveRecord::Migration[5.2]
  def change
    create_table :speaker_outlines do |t|
      t.references :speaker, foreign_key: true
      t.references :outline, foreign_key: true

      t.timestamps
    end
  end
end
