class RenameUserIdToPlayerIdOnPicks < ActiveRecord::Migration
  def change
    rename_column :picks, :user_id, :player_id
  end
end
