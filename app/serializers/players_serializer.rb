class PlayersSerializer < ActiveModel::Serializer
  class PickSerializer < ActiveModel::Serializer
    attributes :rose_order, :rose, :contestant, :id, :weekly_entry_id
    has_one :contestant
  end

  class WeeklyEntrySerializer < ActiveModel::Serializer
    attributes :player_id, :correct_picks, :final_rose_distance
    has_one :week
    has_many :picks, serializer: PickSerializer
  end

  attributes :winner_id, :id
  has_many :weekly_entries, serializer: WeeklyEntrySerializer
end
