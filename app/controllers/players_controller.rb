class PlayersController < ApplicationController

  def show
    player = Player.find(params[:id])
    @season = Season.find(player.season_id)

    @weeks = Week.where(season_id: @season.id)    
    @weeks_json = ActiveModel::ArraySerializer.new(@weeks, each_serializer: WeeksSerializer).to_json
    @contestants = Contestant.where(season_id: @season.id, eliminated: false)
    @eligible_contestants = Contestant.eligible(@season.id)

    current_week_id = @season.current_week_id
    if player.weekly_entries.where(week_id: current_week_id).empty?
      WeeklyEntryFactory.create_entry(player.id, current_week_id, @eligible_contestants)
    end

    @player_json = PlayersSerializer.new(player).to_json
  end

  def update
    player_params = params.require(:player).permit(:winner_id)
    Player.find(params[:id]).update_attributes! player_params
    render json: {}
  end
end
