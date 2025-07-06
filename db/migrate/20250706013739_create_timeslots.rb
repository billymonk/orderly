class CreateTimeslots < ActiveRecord::Migration[8.0]
  def change
    create_table :timeslots do |t|
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.date :slot_date, null: false

      t.timestamps
    end
  end
end
