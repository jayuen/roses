class RenameOrderToRoseOrderOnWeeklyResults < ActiveRecord::Migration
  def change
    rename_column :weekly_results, :order, :rose_order
  end
end
