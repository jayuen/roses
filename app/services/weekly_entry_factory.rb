class WeeklyEntryFactory

  def self.create_entry player_id, week_id, contestants
    week = Week.find(week_id)
    entry = WeeklyEntry.create! week_id: week_id, player_id: player_id, correct_picks: 0

    if week.final_four?
      create_final_picks entry, player_id, week, 4
    elsif week.final_three?
      create_final_picks entry, player_id, week, 3
    elsif week.final_two?
      create_final_picks entry, player_id, week, 2
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

  def self.create_final_picks entry, player_id, week, number_of_picks
    final_regular_week = week.season.final_regular_week
    final_regular_entry = WeeklyEntry.where(player_id: player_id, week_id: final_regular_week.id).first

    create_rose_picks entry, player_id, final_regular_entry, number_of_picks-1
    entry.picks.create! player_id: player_id, contestant: final_regular_entry.nth_pick(number_of_picks).contestant, rose_order: number_of_picks, rose: false
  end

  def self.create_rose_picks entry, player_id, final_regular_entry, number_of_rose_picks
    (number_of_rose_picks).times do |i|
      pick_order = i+1
      entry.picks.create! player_id: player_id, contestant: final_regular_entry.nth_pick(pick_order).contestant, rose_order: pick_order, rose: true
    end
  end
end
