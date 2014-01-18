class Week < ActiveRecord::Base
  has_many :weekly_results
  has_many :weekly_entries
end
