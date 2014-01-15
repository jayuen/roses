class WeeksSerializer < ActiveModel::Serializer
  class WeeklyResultSerializer < ActiveModel::Serializer
    attributes :rose, :rose_order, :week_id, :id
    has_one :contestant
  end

  attributes :id, :name
  has_many :weekly_results, serializer: WeeklyResultSerializer
end
