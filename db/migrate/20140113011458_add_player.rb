class AddPlayer < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :user_id
      t.integer :season_id
      t.integer :winner_id
    end
  end
end
