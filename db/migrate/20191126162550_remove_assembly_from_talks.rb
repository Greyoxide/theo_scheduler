class RemoveAssemblyFromTalks < ActiveRecord::Migration[5.2]
  def change
    remove_column :talks, :assembly, :boolean
  end
end
