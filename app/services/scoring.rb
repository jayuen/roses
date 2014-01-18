module Scoring

  def self.compute(week)
    weekly_entry = week.weekly_entries.first
    weekly_results = week.weekly_results
    set_correct_picks(weekly_entry, weekly_results)
  end

  def self.set_correct_picks(weekly_entry, weekly_results)
    picks = weekly_entry.picks
    picks.each do |pick|
      weekly_result = weekly_results.find{|result| result.contestant == pick.contestant}
      if pick.rose? and weekly_result.rose?
        weekly_entry.correct_picks += 1
      end
    end
  end
end
