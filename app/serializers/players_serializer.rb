class PlayersSerializer < ActiveModel::Serializer
  attributes :winner_id
  has_many :picks
end
