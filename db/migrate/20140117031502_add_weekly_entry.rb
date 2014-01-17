class AddWeeklyEntry < ActiveRecord::Migration
  def change
    create_table :weekly_entries do |t|
      t.integer :week_id
      t.integer :player_id
      t.integer :correct_picks
    end
  end
end
