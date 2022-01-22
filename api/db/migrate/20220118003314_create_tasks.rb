class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|

      t.string :title
      t.boolean :is_done, default: false
      t.date :limit_day
      t.time :limit_time
      t.references :relationship

      t.timestamps
    end
  end
end
