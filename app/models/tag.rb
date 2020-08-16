class Tag < ApplicationRecord
  belongs_to :user
  has_many: :tasks, through: task_tags
end