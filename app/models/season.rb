class Season < ActiveRecord::Base
  has_many :players
  has_many :weeks
  has_many :contestants
  belongs_to :current_week, class_name: 'Week'

  def final_regular_week
    weeks.find {|w| w.final_six? }
  end

  def winner
    contestants_left = contestants.where(eliminated: false)
    contestants_left.size == 1 ? contestants_left.first : nil  
  end
end
