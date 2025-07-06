class Timeslot < ApplicationRecord
  has_many :scheduled_tasks
  has_many :tasks, through: :scheduled_tasks

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :slot_date, presence: true
end
