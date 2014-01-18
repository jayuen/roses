require 'spec_helper.rb'

describe "Services::Scoring" do
  let(:kelly) { Contestant.new }
  let(:sally) { Contestant.new }
  let(:molly) { Contestant.new }

  it "computes the correct picks when all picks are right" do
    week = Week.new
    weekly_entry = week.weekly_entries.build  
    weekly_entry.picks.build rose_order: 1, rose: true, contestant: sally
    week.weekly_results.build rose_order: 1, rose: true, contestant: sally

    Scoring.compute(week)

    weekly_entry.correct_picks.should == 1
  end

  it "computes the correct picks when all picks are wrong" do
    week = Week.new
    weekly_entry = week.weekly_entries.build  
    weekly_entry.picks.build rose_order: 1, rose: false, contestant: sally
    week.weekly_results.build rose_order: 1, rose: true, contestant: sally

    Scoring.compute(week)

    weekly_entry.correct_picks.should == 0
  end
end
