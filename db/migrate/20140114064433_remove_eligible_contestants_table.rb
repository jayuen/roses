class RemoveEligibleContestantsTable < ActiveRecord::Migration
  def change
    drop_table :eligible_contestants
  end
end
