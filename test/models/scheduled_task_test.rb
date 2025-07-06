require "test_helper"

class ScheduledTaskTest < ActiveSupport::TestCase
  test "should not save duplicate scheduled task" do
    duplicate_scheduled_task = ScheduledTask.new(task: scheduled_tasks(:one).task, timeslot: scheduled_tasks(:one).timeslot)
    assert_not duplicate_scheduled_task.valid?
    assert_includes duplicate_scheduled_task.errors[:task_id], "already assigned to this timeslot"
  end
end
