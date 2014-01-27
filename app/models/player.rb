# A player represents the picks for a given season, over many weeks of the season
class Player < ActiveRecord::Base
  has_many :weekly_entries
  belongs_to :user
  belongs_to :winner, class_name: 'Contestant'

  def name
    user.name
  end

  def winner_name
    winner.try(:name)
  end
end
