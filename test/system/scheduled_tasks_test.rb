require "application_system_test_case"

class ScheduledTasksTest < ApplicationSystemTestCase
  fixtures :tasks, :timeslots, :scheduled_tasks

  setup do
    @task_one = tasks(:one)
    @timeslot_one = timeslots(:one)
    @timeslot_two = timeslots(:two)
    @timeslot_three = timeslots(:three)
  end

  test "visiting the index" do
    visit root_url
    assert_selector "h1", text: "Timeslots"
    assert_selector "h1", text: "Tasks"
  end

  test "should drag a task to a timeslot" do
    visit root_url

    within "#timeslot_#{@timeslot_three.id}" do
      assert_no_selector "#task_#{@task_one.id}"
    end

    timeslot_target = find("#timeslot_#{@timeslot_three.id}")
    within "#tasks" do
      find("#task_#{@task_one.id}").drag_to timeslot_target
    end

    assert_selector "#timeslot_#{@timeslot_three.id}" do
      assert_selector "#task_#{@task_one.id}"
    end
  end

  test "should not drag a task to a timeslot if already assigned" do
    visit root_url

    assert_selector "#timeslot_#{@timeslot_one.id} #task_#{@task_one.id}"

    timeslot_target = find("#timeslot_#{@timeslot_one.id}")
    within "#tasks" do
      find("#task_#{@task_one.id}").drag_to timeslot_target
    end

    assert_equal 1, ScheduledTask.where(task: @task_one, timeslot: @timeslot_one).count

    assert_selector "#timeslot_#{@timeslot_one.id} #task_#{@task_one.id}"
  end
end
