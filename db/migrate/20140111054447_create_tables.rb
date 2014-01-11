class CreateTables < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.text :name
    end

    create_table :weeks do |t|
      t.text :name
      t.integer :season_id
    end

    create_table :contestants do |t|
      t.text :first_name
      t.text :last_name
    end

    create_table :eligible_contestants do |t|
      t.integer :contestant_id
      t.integer :week_id
    end

    create_table :picks do |t|
      t.timestamps
      t.integer :week_id
      t.integer :order
      t.integer :contestant_id
      t.boolean :rose
    end

    create_table :weekly_results do |t|
      t.integer :week_id
      t.integer :order
      t.integer :contestant_id
      t.boolean :rose
    end
  end
end
