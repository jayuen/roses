require 'rake'

namespace :roses do
  desc "bootstrap season 18"
  task bootstrap_season_18: :environment do
    season = Season.create! name: 'Season 18', current: true
    week = Week.create! season_id: season.id, name: '2014-01-06 (Week 1)', season_id: season.id, locked: false
    season.update_attributes! current_week_id: week.id

    ['Sharleen', 'Clare', 'Nikki', 'Renee', 'Andi', 'Alli', 'Chantel', 'Lauren S', 'Kelly', 
      'Cassandra', 'Danielle', 'Chelsie', 'Kat', 'Victoria', 'Christy', 'Lucy', 'Elise', 'Amy L',
      'Alexis', 'Amy J', 'Ashley', 'Christine', 'Kylie', 'Lacy', 'Lauren H', 'Maggie', 'Valerie'
    ].each do |name|
      Contestant.create! name: name, season_id: season.id, eliminated: false
    end
  end

  desc "bootstrap Bachelorette Season 10"
  task bootstrap_bachelorette_season_10: :environment do
    season = Season.create! name: 'Bachelorette - Season 10', current: true
    week = Week.create! season_id: season.id, name: '2014-05-19 (Week 1)', season_id: season.id, locked: false
    season.update_attributes! current_week_id: week.id

    ['Marcus', 'Chris', 'J.J.', 'Marquel', 'Tasos', 'Cody', 'Steven', 'Rudie', 'Carl', 
      'Jason', 'Nick V', 'Dylan', 'Patrick', 'Emil', 'Brett', 'Craig', 'Ron', 'Bradley',
      'Josh B', 'Nick S', 'Brian', 'Andrew', 'Mike', 'Eric', 'Josh M'
    ].each do |name|
      Contestant.create! name: name, season_id: season.id, eliminated: false
    end
  end

  desc "provision a new week"
  task :new_week, [:season_name, :name, :episode_type] => :environment do |t,args|
    args.episode_type ||= Week::REGULAR
    season = Season.where(name: args.season_name).first
    Week.where(season_id: season.id).each do |w|
      w.update_attributes! locked: true
    end
    week = Week.create! season_id: season.id, name: args.name, season_id: season.id, locked: false, episode_type: args.episode_type
    season.update_attributes! current_week_id: week.id
  end

  desc "generate final four week"
  task :generate_final_four, [:season_name, :name] => :environment do |t,args|
    Season.transaction do
      season = Season.where(name: args.season_name).first
      Week.where(season_id: season.id).each do |w|
        w.update_attributes! locked: true
      end
      week = Week.create! season_id: season.id, name: args.name, season_id: season.id, locked: true, episode_type: Week::FINAL_FOUR
      season.players.each do |player|
        WeeklyEntryFactory.create_entry(player.id, week.id, [])
      end
      season.update_attributes! current_week_id: week.id
    end
  end

  desc "generate final three week"
  task :generate_final_three, [:season_name, :name] => :environment do |t,args|
    Season.transaction do
      season = Season.where(name: args.season_name).first
      Week.where(season_id: season.id).each do |w|
        w.update_attributes! locked: true
      end
      week = Week.create! season_id: season.id, name: args.name, season_id: season.id, locked: true, episode_type: Week::FINAL_THREE
      season.players.each do |player|
        WeeklyEntryFactory.create_entry(player.id, week.id, [])
      end
      season.update_attributes! current_week_id: week.id
    end
  end

  desc "generate final two week"
  task :generate_final_two, [:season_name, :name] => :environment do |t,args|
    Season.transaction do
      season = Season.where(name: args.season_name).first
      Week.where(season_id: season.id).each do |w|
        w.update_attributes! locked: true
      end
      week = Week.create! season_id: season.id, name: args.name, season_id: season.id, locked: true, episode_type: Week::FINAL_TWO
      season.players.each do |player|
        WeeklyEntryFactory.create_entry(player.id, week.id, [])
      end
      season.update_attributes! current_week_id: week.id
    end
  end

  desc "provision a new admin"
  task :new_admin, [:email] => :environment do |t, args|
    User.where(email: args.email).first.update_attributes! admin: true
  end

  desc "lockdown winner"
  task :lockdown_winner, [:season_name, :lockdown] => :environment do |t,args|
    season = Season.where(name: args.season_name).first
    season.update_attributes! lockdown_winner: args.lockdown
  end

  desc "lockdown week"
  task :lockdown_week, [:season_name, :week_name, :locked] => :environment do |t,args|
    season = Season.where(name: args.season_name).first
    week = Week.where(season_id: season.id, name: args.week_name).first
    week.update_attributes! locked: args.locked
  end
end
