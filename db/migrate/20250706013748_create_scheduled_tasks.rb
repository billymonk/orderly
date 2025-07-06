class CreateScheduledTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :scheduled_tasks do |t|
      t.references :task, null: false, foreign_key: true
      t.references :timeslot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
