class PlayersSerializer < ActiveModel::Serializer
  class PickSerializer < ActiveModel::Serializer
    attributes :rose_order, :rose, :week_id, :contestant, :id#, :last_updated
    has_one :contestant
=begin
    def last_updated
      object.updated_at.strftime('%Y-%m-%d %I:%M %p')
    end
=end
  end

  attributes :winner_id, :id
  has_many :picks, serializer: PickSerializer
end
