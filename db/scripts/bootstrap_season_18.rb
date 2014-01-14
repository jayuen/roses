season = Season.create! name: 'Season 18 - Juan Pablo', current: true
Week.create! season_id: season.id, name: '2014-01-20 - Week 3', season_id: season.id, locked: true
week2 = Week.create! season_id: season.id, name: '2014-01-13 - Week 2', season_id: season.id, locked: false
Week.create! season_id: season.id, name: '2014-01-06 - Week 1', season_id: season.id, locked: false
season.update_attributes! current_week_id: week2.id

['Sharleen', 'Clare', 'Nikki', 'Renee', 'Andi', 'Alli', 'Chantel', 'Lauren S', 'Kelly', 
  'Cassandra', 'Danielle', 'Chelsie', 'Kat', 'Victoria', 'Christy', 'Lucy', 'Elise', 'Amy L',
  'Alexis', 'Amy J', 'Ashley', 'Christine', 'Kylie', 'Lacy', 'Lauren H', 'Maggie', 'Valerie'
].each do |name|
  Contestant.create! name: name, season_id: season.id, eliminated: false
end
