require 'spec_helper.rb'

describe WeeklyEntryFactory do
  let!(:player) {Player.create!}
  let!(:season) {Season.create!}
  let!(:final_six_week) {Week.create! season: season, episode_type: Week::FINAL_SIX}
  let(:sara) {Contestant.create!}
  let(:mary) {Contestant.create!}
  let(:heidi) {Contestant.create!}
  let(:kate) {Contestant.create!}
  let(:june) {Contestant.create!}
  let(:laura) {Contestant.create!}
  let!(:final_six_entry) do
    entry = WeeklyEntry.create! week: final_six_week, player_id: player.id
    entry.picks.create! player_id: player.id, contestant: sara, rose_order: 6  
    entry.picks.create! player_id: player.id, contestant: mary, rose_order: 5  
    entry.picks.create! player_id: player.id, contestant: heidi, rose_order: 4  
    entry.picks.create! player_id: player.id, contestant: kate, rose_order: 3  
    entry.picks.create! player_id: player.id, contestant: june, rose_order: 2  
    entry.picks.create! player_id: player.id, contestant: laura, rose_order: 1  
    entry
  end

  describe "final four entry" do
    it "uses the top four picks from the final six week" do
      final_four_week = Week.create! season: season, episode_type: Week::FINAL_FOUR
      new_entry = WeeklyEntryFactory.create_entry player.id, final_four_week.id, [] 

      expect(new_entry.picks.size).to eq(4)
      sorted = new_entry.picks.sort {|x,y| x.rose_order <=> y.rose_order}
      expect(sorted[0].contestant).to eq(laura)
      expect(sorted[0].rose).to eq(true)

      expect(sorted[1].contestant).to eq(june)
      expect(sorted[1].rose).to eq(true)

      expect(sorted[2].contestant).to eq(kate)
      expect(sorted[2].rose).to eq(true)

      expect(sorted[3].contestant).to eq(heidi)
      expect(sorted[3].rose).to eq(false)
    end
  end

  describe "final three entry" do
    it "uses the top three picks from the final six week" do
      final_three_week = Week.create! season: season, episode_type: Week::FINAL_THREE
      new_entry = WeeklyEntryFactory.create_entry player.id, final_three_week.id, [] 

      expect(new_entry.picks.size).to eq(3)
      sorted = new_entry.picks.sort {|x,y| x.rose_order <=> y.rose_order}
      expect(sorted[0].contestant).to eq(laura)
      expect(sorted[0].rose).to eq(true)

      expect(sorted[1].contestant).to eq(june)
      expect(sorted[1].rose).to eq(true)

      expect(sorted[2].contestant).to eq(kate)
      expect(sorted[2].rose).to eq(false)
    end
  end

  describe "final two entry" do
    it "uses the top two picks from the final three week" do
      final_two_week = Week.create! season: season, episode_type: Week::FINAL_TWO
      new_entry = WeeklyEntryFactory.create_entry player.id, final_two_week.id, [] 

      expect(new_entry.picks.size).to eq(2)
      sorted = new_entry.picks.sort {|x,y| x.rose_order <=> y.rose_order}
      expect(sorted[0].contestant).to eq(laura)
      expect(sorted[0].rose).to eq(true)

      expect(sorted[1].contestant).to eq(june)
      expect(sorted[1].rose).to eq(false)
    end
  end
end
