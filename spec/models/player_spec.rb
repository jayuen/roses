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
end
