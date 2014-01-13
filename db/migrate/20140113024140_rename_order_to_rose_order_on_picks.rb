class RenameOrderToRoseOrderOnPicks < ActiveRecord::Migration
  def change
    rename_column :picks, :order, :rose_order
  end
end
