class AddScoreToEntry < ActiveRecord::Migration
  def change
    add_column :weekly_entries, :score, :integer, :default => 0
  end
end
