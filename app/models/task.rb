class Task < ApplicationRecord
  has_many :scheduled_tasks
  has_many :timeslots, through: :scheduled_tasks

  validates :name, presence: true
end
