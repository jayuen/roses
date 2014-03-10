class Season < ActiveRecord::Base
  has_many :players
  has_many :weeks

  def final_regular_week
    weeks.find {|w| w.final_six? }
  end
end
