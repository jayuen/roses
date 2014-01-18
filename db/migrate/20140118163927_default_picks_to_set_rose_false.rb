class DefaultPicksToSetRoseFalse < ActiveRecord::Migration
  def change
    change_column :picks, :rose, :boolean, default: false
  end
end
