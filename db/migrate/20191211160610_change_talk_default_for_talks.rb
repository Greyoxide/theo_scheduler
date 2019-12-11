class ChangeTalkDefaultForTalks < ActiveRecord::Migration[5.2]
  def up
  	change_column :talks, :kind, :integer, :default => 0
  end

  def down
  	change_column :talks, :kind, :integer, :default => nil
  end

end
