class UsersController < ApplicationController
  def show
    season = Season.where(current: true).first
    current_week_id = season.current_week_id
    @weeks = Week.where(season_id: season.id)    

    @contestants = Contestant.where(season_id: season.id, eliminated: false)
    @eligible_contestants = EligibleContestant.where(week_id: current_week_id)

    @user = User.find(params[:id])
    picks = Pick.where("week_id IN (:week_ids) AND user_id = :user_id", week_ids: @weeks.pluck(:id), user_id: params[:id])
    if picks.empty?
      picks = @eligible_contestants.map do |c|
        Pick.create! user_id: params[:id], week_id: current_week_id
      end
    end
    @user.picks = picks 
    puts @user.picks
  end
end
