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
    @eligible_contestants = Contestant.eligible(@current_season.id)
    weeks = Week.where(season_id: @current_season.id)
    current_week = weeks.find {|w| @current_season.current_week_id == w.id}
    if current_week.weekly_results.empty?
      @eligible_contestants.each_with_index do |c, index|
        WeeklyResult.create! week_id: current_week.id
      end
    end
    @weeks = ActiveModel::ArraySerializer.new(weeks, each_serializer: WeeksSerializer)
  end
end
