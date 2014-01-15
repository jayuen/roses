class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :user_signed_in?
  before_filter :set_season, :set_player

  def set_season
    @current_season = Season.where(current: true).first
  end

  def set_player
    if current_user
      @player = Player.where(season_id: @current_season.id, user_id: current_user.id).first
    end
  end

  def index
    if current_user
      redirect_to player_path(@player)
    end
  end

  def admin
    @contestants = Contestant.where(season_id: @current_season.id)
  end
end
