class PlayersController < ApplicationController

  def show
    player = Player.find(params[:id])
    season = Season.find(player.season_id)

    @weeks = Week.where(season_id: season.id)    
    @contestants = Contestant.where(season_id: season.id, eliminated: false)

    current_week_id = season.current_week_id
    @eligible_contestants = Contestant.eligible(season.id)

    if player.picks.empty?
      @eligible_contestants.each_with_index do |c, index|
        player.picks.create! rose_order: index+1, player_id: player.id, week_id: current_week_id 
      end
    end

    @player_json = PlayersSerializer.new(player).to_json
  end

  def update
    player_params = params.require(:player).permit(:winner_id)
    Player.find(params[:id]).update_attributes! player_params
    render json: {}
  end
end
