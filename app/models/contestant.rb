class Contestant < ActiveRecord::Base
  def self.eligible(season_id)
    Contestant.where(season_id: season_id, eliminated: false)
  end
end
