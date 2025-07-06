require "test_helper"

class TimeslotTest < ActiveSupport::TestCase
  test "start_time must be present" do
    timeslot = timeslots(:one)
    timeslot.start_time = nil
    assert_not timeslot.valid?
    assert_includes timeslot.errors[:start_time], "can't be blank"
  end

  test "end_time must be present" do
    timeslot = timeslots(:one)
    timeslot.end_time = nil
    assert_not timeslot.valid?
    assert_includes timeslot.errors[:end_time], "can't be blank"
  end

  test "slot_date must be present" do
    timeslot = timeslots(:one)
    timeslot.slot_date = nil
    assert_not timeslot.valid?
    assert_includes timeslot.errors[:slot_date], "can't be blank"
  end
end
