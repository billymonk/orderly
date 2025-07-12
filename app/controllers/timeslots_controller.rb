class TimeslotsController < ApplicationController
  def index
    @timeslots = Timeslot.includes(:tasks, :scheduled_tasks).all
    @tasks = Task.all
  end
end
