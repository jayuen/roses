class AddLockedToWeek < ActiveRecord::Migration
  def change
    add_column :weeks, :locked, :boolean, default: true
  end
end
