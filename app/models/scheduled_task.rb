class ScheduledTask < ApplicationRecord
  belongs_to :task
  belongs_to :timeslot

  validates :task_id, uniqueness: { scope: :timeslot_id, message: "already assigned to this timeslot" }
end
