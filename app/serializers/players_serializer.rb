class PlayersSerializer < ActiveModel::Serializer
  class PickSerializer < ActiveModel::Serializer
    attributes :rose_order, :rose, :week_id, :contestant, :id
    has_one :contestant
  end

  attributes :winner_id
  has_many :picks, serializer: PickSerializer
end
