class TagSerializer < ActiveModel::Serializer
  attributes :id, :title, :color
  has_one :user
end
