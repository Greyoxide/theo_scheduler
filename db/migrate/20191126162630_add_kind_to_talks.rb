class AddKindToTalks < ActiveRecord::Migration[5.2]
  def change
    add_column :talks, :kind, :integer
  end
end
