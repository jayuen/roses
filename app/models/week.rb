class Week < ActiveRecord::Base
  FINAL_FOUR = 'final_four'
  FINAL_SIX = 'final_six'
  FINAL_THREE = 'final_three'
  FINAL_TWO = 'final_two'
  REGULAR = 'regular'

  has_many :weekly_results
  has_many :weekly_entries
  belongs_to :season

  def final_two?
    self.episode_type == FINAL_TWO
  end

  def final_three?
    self.episode_type == FINAL_THREE
  end

  def final_four?
    self.episode_type == FINAL_FOUR
  end

  def final_six?
    self.episode_type == FINAL_SIX
  end

  def regular?
    self.episode_type == REGULAR
  end
end
