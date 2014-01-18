module Scoring

  def self.compute(week)
    weekly_entry = week.weekly_entries.first
    weekly_results = week.weekly_results

    set_correct_picks(weekly_entry, weekly_results)
    set_final_rose_distance(weekly_entry, weekly_results)
    weekly_entry.save!
  end

  def self.set_correct_picks(weekly_entry, weekly_results)
    weekly_entry.correct_picks = 0
    picks = weekly_entry.picks
    picks.each do |pick|
      weekly_result = weekly_results.find{|result| result.contestant == pick.contestant}
      if pick.rose? and weekly_result.rose?
        weekly_entry.correct_picks += 1
      end
    end
  end

  def self.reverse_rose_order(weekly_results)
    weekly_results.
      find_all {|result| result.rose}.
      sort {|pick1, pick2| pick2.rose_order <=> pick1.rose_order}
  end

  def self.set_final_rose_distance(weekly_entry, weekly_results)
    final_rose_pick = weekly_entry.final_rose_pick 
    reverse_rose_order = reverse_rose_order(weekly_results)

    final_rose_distance = 0
    reverse_rose_order.each do |result|
      final_rose_match = result.contestant == final_rose_pick.contestant
      final_rose_match ? break : final_rose_distance -= 1
    end

    weekly_entry.final_rose_distance = final_rose_distance
  end
end
