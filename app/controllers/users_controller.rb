class UsersController < ApplicationController
  def show
    season = Season.where(current: true).first
    weeks = Week.where(season_id: season.id)    
    picks = Pick.where("week_id IN (:week_ids)", week_ids: weeks.pluck(:id))

    contestants = Contestant.where(season_id: season.id, eliminated: false)
    this_week = Week.where(season_id: season.id, locked: false).first
    eligible_contestants = EligibleContestant.where(week_id: this_week.id)
  end
end
