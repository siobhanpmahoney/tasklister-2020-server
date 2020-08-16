class TaskTagSerializer < ActiveModel::Serializer
  has_one :task
  has_one :tag
end
