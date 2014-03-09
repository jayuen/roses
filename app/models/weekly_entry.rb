class WeeklyEntry < ActiveRecord::Base
  has_many :picks
  belongs_to :week

  def final_rose_pick
    picks.find_all {|pick| pick.rose}.
      sort {|pick1, pick2| pick1.rose_order <=> pick2.rose_order}.last
  end

  def nth_pick n
    picks.find {|p| p.rose_order == n}
  end

  def tiebreaker
    correct_picks + final_rose_distance
  end
end
