class ScheduledTasksController < ApplicationController
  include ActionView::RecordIdentifier

  def create
    @scheduled_task = ScheduledTask.new(scheduled_task_params)

    if @scheduled_task.save
      @task = @scheduled_task.task
      @timeslot = @scheduled_task.timeslot
      @timeslot.reload # Reload the timeslot to get the updated tasks association

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(dom_id(@timeslot), partial: "timeslots/timeslot", locals: { timeslot: @timeslot })
          ]
        end
      end
    else
      respond_to do |format|
        format.turbo_stream { head :unprocessable_entity }
      end
    end
  end

  private

  def scheduled_task_params
    params.require(:scheduled_task).permit(:task_id, :timeslot_id)
  end
end
