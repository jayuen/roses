class AddWeeklyEntryIdToPick < ActiveRecord::Migration
  def change
    add_column :picks, :weekly_entry_id, :integer
    remove_column :picks, :week_id
  end
end
