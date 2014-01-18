require 'spec_helper.rb'

describe "Services::Scoring" do
  let(:kelly) { Contestant.new }
  let(:sally) { Contestant.new }
  let(:molly) { Contestant.new }

  describe "set_correct_picks" do
    it "set the correct picks when all picks are right" do
      weekly_entry = WeeklyEntry.new
      weekly_entry.picks.build rose_order: 1, rose: true, contestant: sally
      weekly_result = WeeklyResult.new rose_order: 1, rose: true, contestant: sally

      Scoring.set_correct_picks(weekly_entry, [weekly_result])

      weekly_entry.correct_picks.should == 1
    end

    it "sets the correct picks when all picks are wrong" do
      weekly_entry = WeeklyEntry.new
      weekly_entry.picks.build rose_order: 1, rose: false, contestant: sally
      weekly_result = WeeklyResult.new rose_order: 1, rose: true, contestant: sally

      Scoring.set_correct_picks(weekly_entry, [weekly_result])

      weekly_entry.correct_picks.should == 0
    end
  end

  describe "set_final_rose_distance" do
    xit "computes the final rose distance" do
      weekly_entry = week.weekly_entries.build  
      weekly_entry.picks.build rose_order: 1, rose: true, contestant: sally
      weekly_entry.picks.build rose_order: 2, rose: true, contestant: molly
      weekly_entry.picks.build rose_order: 3, rose: true, contestant: kelly

      week.weekly_results.build rose_order: 1, rose: true, contestant: kelly
      week.weekly_results.build rose_order: 2, rose: true, contestant: sally
      week.weekly_results.build rose_order: 3, rose: true, contestant: molly

      Scoring.compute(week)

      weekly_entry.correct_picks.should == 0
    end
  end
end
