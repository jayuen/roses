class WeeklyEntryFactory

  def self.create_entry player_id, week_id, contestants
    week = Week.find(week_id)
    entry = WeeklyEntry.create! week_id: week_id, player_id: player_id, correct_picks: 0

    if week.final_four?
      create_final_four_picks entry, player_id, week
    elsif week.final_three?
      create_final_three_picks entry, player_id, week
    elsif week.final_two?
      create_final_two_picks entry, player_id, week
    else
      create_regular_picks entry, player_id, contestants
    end
    entry
  end

  private
  
  def self.create_regular_picks entry, player_id, contestants
    contestants.each_with_index do |c, index|
      entry.picks.create! rose_order: index+1, player_id: player_id
    end
  end

  def self.create_final_four_picks entry, player_id, week
    final_six_week = week.season.final_six_week
    final_six_entry = WeeklyEntry.where(week_id: final_six_week.id).first
    entry.picks.create! player_id: player_id, contestant: final_six_entry.nth_pick(1).contestant, rose_order: 1, rose: true
    entry.picks.create! player_id: player_id, contestant: final_six_entry.nth_pick(2).contestant, rose_order: 2, rose: true
    entry.picks.create! player_id: player_id, contestant: final_six_entry.nth_pick(3).contestant, rose_order: 3, rose: true
    entry.picks.create! player_id: player_id, contestant: final_six_entry.nth_pick(4).contestant, rose_order: 4, rose: false
  end

  def self.create_final_three_picks entry, player_id, week
    final_four_week = week.season.final_four_week
    final_four_entry = WeeklyEntry.where(week_id: final_four_week.id).first
    entry.picks.create! player_id: player_id, contestant: final_four_entry.nth_pick(1).contestant, rose_order: 1, rose: true
    entry.picks.create! player_id: player_id, contestant: final_four_entry.nth_pick(2).contestant, rose_order: 2, rose: true
    entry.picks.create! player_id: player_id, contestant: final_four_entry.nth_pick(3).contestant, rose_order: 3, rose: false
  end

  def self.create_final_two_picks entry, player_id, week
    final_three_week = week.season.final_three_week
    final_three_entry = WeeklyEntry.where(week_id: final_three_week.id).first
    entry.picks.create! player_id: player_id, contestant: final_three_entry.nth_pick(1).contestant, rose_order: 1, rose: true
    entry.picks.create! player_id: player_id, contestant: final_three_entry.nth_pick(2).contestant, rose_order: 2, rose: false
  end
end
