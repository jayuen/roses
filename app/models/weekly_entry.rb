class WeeklyEntry < ActiveRecord::Base
  has_many :picks
  belongs_to :week
end
