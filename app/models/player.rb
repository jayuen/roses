# A player represents the picks for a given season, over many weeks of the season
class Player < ActiveRecord::Base
  has_many :weekly_entries
  belongs_to :user
  belongs_to :winner, class_name: 'Contestant'
  belongs_to :season

  def name
    user.name
  end

  def winner_name
    winner.try(:name)
  end

  def total_score
    self.weekly_entries.to_a.sum(&:score)
  end

  def winner_score
    return 0 unless self.winner

    season.winner == self.winner ? 10 : 0
  end
end
