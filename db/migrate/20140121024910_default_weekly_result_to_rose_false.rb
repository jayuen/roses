class DefaultWeeklyResultToRoseFalse < ActiveRecord::Migration
  def up
    change_column :weekly_results, :rose, :boolean, default: false

    execute "UPDATE weekly_results SET rose = false WHERE rose IS NOT true"
  end

  def down
    change_column :weekly_results, :rose, :boolean
  end
end
