class TimeslotsController < ApplicationController
  def index
    @timeslots = Timeslot.all
    @tasks = Task.all
  end
end
