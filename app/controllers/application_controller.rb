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
        WeeklyResult.create! week_id: current_week.id, rose_order: index+1
      end
    end
    @weeks = ActiveModel::ArraySerializer.new(weeks, each_serializer: WeeksSerializer)
  end

  def instructions
  end

  class PlayerSerializer < ActiveModel::Serializer
    attributes :name, :winner_name
  end

  def standings
    @weeks = @current_season.weeks.sort {|x,y| x.name <=> y.name }
    @players_json = ActiveModel::ArraySerializer.new(@current_season.players, each_serializer: PlayerSerializer).to_json
    @standings = generate_standings(@weeks, @current_season.players)
  end

  Standing = Struct.new(:week_name, :player_name, :standing, :points, :correct_picks)

  def generate_standings weeks, players
    standings = []
    weeks.each do |week|
      players.each do |player|
        entry = WeeklyEntry.where(week_id: week.id, player_id: player.id).first
        if entry
          standings << Standing.new(week.name, player.name, entry.standing, Scoring::POINTS.fetch(entry.standing, 0), entry.correct_picks)
        else
          standings << Standing.new(week.name, player.name, nil, 0, 0)
        end
      end
    end
    standings
  end
end
