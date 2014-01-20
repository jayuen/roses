class AddStandingToWeeklyEntries < ActiveRecord::Migration
  def change
    add_column :weekly_entries, :standing, :integer
  end
end
