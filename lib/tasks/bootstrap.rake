require 'rake'

namespace :bootstrap do
  task season_18_data: :environment do
    season = Season.create! name: 'Season 18', current: true
    week = Week.create! season_id: season.id, name: '2014-01-06 - Week 1', season_id: season.id, locked: false
    season.update_attributes! current_week_id: week.id

    ['Sharleen', 'Clare', 'Nikki', 'Renee', 'Andi', 'Alli', 'Chantel', 'Lauren S', 'Kelly', 
      'Cassandra', 'Danielle', 'Chelsie', 'Kat', 'Victoria', 'Christy', 'Lucy', 'Elise', 'Amy L',
      'Alexis', 'Amy J', 'Ashley', 'Christine', 'Kylie', 'Lacy', 'Lauren H', 'Maggie', 'Valerie'
    ].each do |name|
      Contestant.create! name: name, season_id: season.id, eliminated: false
    end
  end

  task :new_week, [:season_name, :name] => :environment do |t,args|
    season = Season.where(name: args.season_name).first
    week = Week.create! season_id: season.id, name: args.name, season_id: season.id, locked: false
    season.update_attributes! current_week_id: week.id
  end
end
