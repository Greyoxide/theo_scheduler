class AddStatusToOutlines < ActiveRecord::Migration[5.2]
  def change
    add_column :outlines, :status, :integer, default: 0
  end
end
