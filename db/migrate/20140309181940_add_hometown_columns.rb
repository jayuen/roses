class AddHometownColumns < ActiveRecord::Migration
  def change
    add_column :weeks, :episode_type, :string, default: 'regular'
  end
end
