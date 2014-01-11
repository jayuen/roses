class AddSeasonAndEliminatedToContestant < ActiveRecord::Migration
  def change
    add_column :contestants, :season_id, :integer
    add_column :contestants, :eliminated, :boolean
  end
end
