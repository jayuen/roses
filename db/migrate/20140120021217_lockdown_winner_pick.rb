class LockdownWinnerPick < ActiveRecord::Migration
  def change
    add_column :seasons, :lockdown_winner, :boolean, default: false
  end
end
