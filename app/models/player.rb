# A player represents the picks for a given season, over many weeks of the season
class Player < ActiveRecord::Base
  has_many :picks
end
