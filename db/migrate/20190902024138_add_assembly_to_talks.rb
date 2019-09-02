class AddAssemblyToTalks < ActiveRecord::Migration[5.2]
  def change
    add_column :talks, :assembly, :boolean
  end
end
