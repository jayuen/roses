require 'spec_helper.rb'

describe "Services::Scoring" do
  let(:kelly) { Contestant.new }
  let(:sally) { Contestant.new }
  let(:molly) { Contestant.new }
  let(:weekly_entry) { WeeklyEntry.new }

  describe "set_correct_picks" do
    it "set the correct picks when all rose picks are right" do
      weekly_entry.picks.build rose: true, contestant: sally
      weekly_result = WeeklyResult.new rose: true, contestant: sally

      Scoring.set_correct_picks(weekly_entry, [weekly_result])

      weekly_entry.correct_picks.should == 1
    end

    it "set the correct picks when all no rose picks are right" do
      weekly_entry.picks.build rose: false, contestant: sally
      weekly_result = WeeklyResult.new rose: false, contestant: sally

      Scoring.set_correct_picks(weekly_entry, [weekly_result])

      weekly_entry.correct_picks.should == 1
    end

    it "sets the correct picks when all picks are wrong" do
      weekly_entry.picks.build rose: false, contestant: sally
      weekly_result = WeeklyResult.new rose: true, contestant: sally

      Scoring.set_correct_picks(weekly_entry, [weekly_result])

      weekly_entry.correct_picks.should == 0
    end

    it "resets the correct picks" do
      weekly_entry.correct_picks = 5
      weekly_entry.picks.build rose: true, contestant: sally
      weekly_result = WeeklyResult.new rose: true, contestant: sally

      Scoring.set_correct_picks(weekly_entry, [weekly_result])

      weekly_entry.correct_picks.should == 1
    end
  end

  describe "set_final_rose_distance" do
    it "computes the final rose distance" do
      weekly_entry.picks.build rose_order: 1, rose: true, contestant: sally
      weekly_entry.picks.build rose_order: 2, rose: true, contestant: molly
      weekly_entry.picks.build rose_order: 3, rose: true, contestant: kelly

      results = []
      results << WeeklyResult.new(rose_order: 1, rose: true, contestant: kelly)
      results << WeeklyResult.new(rose_order: 2, rose: true, contestant: sally)
      results << WeeklyResult.new(rose_order: 3, rose: true, contestant: molly)

      Scoring.set_final_rose_distance(weekly_entry, results)

      weekly_entry.final_rose_distance.should == -2
    end

    it "returns a large distance when no roses are given" do
      weekly_entry.picks.build rose_order: 1, rose: false, contestant: sally
      results  = [WeeklyResult.new(rose_order: 1, rose: true, contestant: sally)]

      Scoring.set_final_rose_distance(weekly_entry, results)

      weekly_entry.final_rose_distance.should == Scoring::NO_FINAL_ROSE
    end
  end

  describe "compute standings" do
    example do
      first = WeeklyEntry.new(correct_picks: 3) 
      second = WeeklyEntry.new(correct_picks: 2) 

      Scoring.compute_standings([first, second])

      first.standing.should == 1
      second.standing.should == 2
    end

    it "uses the final rose distance to break ties" do
      third = WeeklyEntry.new(correct_picks: 3, final_rose_distance: -3) 
      first = WeeklyEntry.new(correct_picks: 3, final_rose_distance: -1) 
      second = WeeklyEntry.new(correct_picks: 3, final_rose_distance: -2) 

      Scoring.compute_standings([third, second, first])

      first.standing.should == 1
      second.standing.should == 2
      third.standing.should == 3
    end

    # Not classic tiebreaking.  It should be 1, 1, 3, rather than 1, 1, 2 but the former is harder to implement!
    it "results in a tie when the final rose distance is the same" do
      third = WeeklyEntry.new(correct_picks: 3, final_rose_distance: -3) 
      first = WeeklyEntry.new(correct_picks: 3, final_rose_distance: -1) 
      first_tie = WeeklyEntry.new(correct_picks: 3, final_rose_distance: -1) 

      Scoring.compute_standings([third, first_tie, first])

      first.standing.should == 1
      first_tie.standing.should == 1
      third.standing.should == 2
    end

    it "gives three points to first, two points to second, one point to third" do
      first = WeeklyEntry.new(correct_picks: 3) 
      second = WeeklyEntry.new(correct_picks: 2) 
      third = WeeklyEntry.new(correct_picks: 1) 

      Scoring.compute_standings([first, third, second])

      first.score.should == 3
      second.score.should == 2
      third.score.should == 1
    end
  end

  describe "scoring for final week" do
    it "" do
    end
  end
end
