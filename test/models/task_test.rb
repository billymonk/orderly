require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "name must be present" do
    task = tasks(:one)
    task.name = nil
    assert_not task.valid?
    assert_includes task.errors[:name], "can't be blank"
  end
end
