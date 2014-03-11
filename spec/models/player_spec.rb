require 'spec_helper'

describe Player do
  describe 'winner_name' do
    example do
      joan = Contestant.create! name: 'joan'
      p = Player.create! winner: joan

      p.winner_name.should == 'joan'
    end

    it "handles nil" do
      p = Player.create! winner: nil

      p.winner_name.should == nil
    end
  end

  describe "total score" do
    it "sums the score from the weekly entries" do
      p = Player.create!
      p.weekly_entries.create! score: 10
      p.weekly_entries.create! score: 1

      expect(p.total_score).to eq(11)
    end
  end

  describe "winner pick score" do
    let(:clare) {Contestant.create!}
    let(:nikki) {Contestant.create!}

    it "return 0 when current week is not final week" do
      w = Week.create! episode_type: Week::REGULAR
      s = Season.create! current_week: w 
      clare = Contestant.create!
      p = Player.create! season: s, winner: clare

      expect(p.winner_score).to eq(0)
    end

    describe "when current week is final week" do
      it "return 0 when winner is not known" do
        w = Week.create! episode_type: Week::FINAL_TWO
        s = Season.create! current_week: w 
        clare.update_attributes! eliminated: false
        nikki.update_attributes! eliminated: false
        s.contestants << clare
        s.contestants << nikki
        p = Player.create! season: s, winner: clare

        expect(p.winner_score).to eq(0)
      end

      it "returns 0 when winner pick does not match" do
        w = Week.create! episode_type: Week::FINAL_TWO
        s = Season.create! current_week: w 
        clare.update_attributes! eliminated: true
        nikki.update_attributes! eliminated: false
        s.contestants << clare
        s.contestants << nikki
        p = Player.create! season: s, winner: clare

        expect(p.winner_score).to eq(0)
      end

      it "returns 0 when winner pick is nil and winner is not known" do
        w = Week.create! episode_type: Week::FINAL_TWO
        s = Season.create! current_week: w 
        clare.update_attributes! eliminated: false
        nikki.update_attributes! eliminated: false
        s.contestants << clare
        s.contestants << nikki
        p = Player.create! season: s

        expect(p.winner_score).to eq(0)
      end

      it "returns 10 when winner pick matches" do
        w = Week.create! episode_type: Week::FINAL_TWO
        s = Season.create! current_week: w 
        clare.update_attributes! eliminated: false
        nikki.update_attributes! eliminated: true
        s.contestants << clare
        s.contestants << nikki
        p = Player.create! season: s, winner: clare

        expect(p.winner_score).to eq(10)
      end
    end
  end
end
