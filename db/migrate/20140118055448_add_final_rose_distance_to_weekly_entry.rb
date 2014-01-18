class AddFinalRoseDistanceToWeeklyEntry < ActiveRecord::Migration
  def change
    add_column :weekly_entries, :final_rose_distance, :integer, default: 0
  end
end
