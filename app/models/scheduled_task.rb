class ScheduledTask < ApplicationRecord
  belongs_to :task
  belongs_to :timeslot
end