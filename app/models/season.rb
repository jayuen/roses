class Season < ActiveRecord::Base
  has_many :players
  has_many :weeks

  def final_six_week
    weeks.find {|w| w.final_six? }
  end

  def final_four_week
    weeks.find {|w| w.final_four? }
  end

  def final_three_week
    weeks.find {|w| w.final_three? }
  end
end
