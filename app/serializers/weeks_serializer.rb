class WeeksSerializer < ActiveModel::Serializer
  attributes :name
  has_many :weekly_results
end
