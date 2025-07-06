class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.text :description
      t.datetime :completed_at

      t.timestamps
    end
  end
end
