class UsersController < ApplicationController
  def show
    season = Season.where(current: true).first
    current_week_id = season.current_week_id
    @weeks = Week.where(season_id: season.id)    

    @contestants = Contestant.where(season_id: season.id, eliminated: false)
    @eligible_contestants = EligibleContestant.where(week_id: current_week_id).map {|ec| ec.contestant }
  end
end
