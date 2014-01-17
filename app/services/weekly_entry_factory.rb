class WeeklyEntryFactory

  def self.create_entry player_id, week_id, contestants
    entry = WeeklyEntry.create! week_id: week_id, player_id: player_id, correct_picks: 0
    contestants.each_with_index do |c, index|
      entry.picks.create! rose_order: index+1, player_id: player_id
    end
  end
    
end
