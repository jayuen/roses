class MergeNameColumnsOnContestant < ActiveRecord::Migration
  def change
    remove_column :contestants, :last_name
    rename_column :contestants, :first_name, :name 
  end
end
