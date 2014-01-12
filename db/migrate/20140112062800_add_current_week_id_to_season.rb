class AddCurrentWeekIdToSeason < ActiveRecord::Migration
  def change
    add_column :seasons, :current_week_id, :integer
  end
end
