class SetDefaultOnWeeklyEntry < ActiveRecord::Migration
  def change
    change_column :weekly_entries, :correct_picks, :integer, default: 0
  end
end
