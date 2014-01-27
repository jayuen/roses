module Scoring
  extend self

  POINTS = {1 => 3, 2 => 2, 3 => 1}
  NO_FINAL_ROSE = -100

  def compute(week)
    week.weekly_entries.each do |weekly_entry|
      compute_score_for(weekly_entry, week.weekly_results)
    end

    compute_standings(week.weekly_entries)

    week.weekly_entries.each do |weekly_entry|
      weekly_entry.save!
    end
  end

  Score = Struct.new(:correct_picks, :tiebreaker)

  def compute_standings(entries)
    ranked_correct_picks = entries.map {|_| Score.new(_.correct_picks, _.tiebreaker)}.uniq.sort {|x,y| [y.correct_picks, y.tiebreaker] <=> [x.correct_picks, x.tiebreaker]}

    ranked_entries = entries.
      sort do |entry1, entry2|
        if entry1.correct_picks != entry2.correct_picks
          entry2.correct_picks <=> entry1.correct_picks
        else
          entry2.tiebreaker <=> entry1.tiebreaker
        end
      end

    ranked_entries.each_with_index do |entry, index|
      entry.standing = ranked_correct_picks.index(Score.new(entry.correct_picks, entry.tiebreaker))+1
    end
  end

  def compute_score_for(weekly_entry, weekly_results)
    set_correct_picks(weekly_entry, weekly_results)
    set_final_rose_distance(weekly_entry, weekly_results)
  end

  def set_correct_picks(weekly_entry, weekly_results)
    weekly_entry.correct_picks = 0
    picks = weekly_entry.picks
    picks.each do |pick|
      weekly_result = weekly_results.find{|result| result.contestant == pick.contestant}
      if pick.rose? and weekly_result.rose?
        weekly_entry.correct_picks += 1
      end
    end
  end

  def reverse_rose_order(weekly_results)
    weekly_results.
      find_all {|result| result.rose}.
      sort {|pick1, pick2| pick2.rose_order <=> pick1.rose_order}
  end

  def set_final_rose_distance(weekly_entry, weekly_results)
    final_rose_pick = weekly_entry.final_rose_pick 
    reverse_rose_order = reverse_rose_order(weekly_results)

    final_rose_distance = 0
    if final_rose_pick
      reverse_rose_order.each do |result|
        final_rose_match = result.contestant == final_rose_pick.contestant
        final_rose_match ? break : final_rose_distance -= 1
      end
    else
      final_rose_distance = NO_FINAL_ROSE
    end

    weekly_entry.final_rose_distance = final_rose_distance
  end
end
