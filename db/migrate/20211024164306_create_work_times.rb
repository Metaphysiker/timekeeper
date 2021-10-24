class CreateWorkTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :work_times do |t|
      t.string :task
      t.integer :minutes
      t.belongs_to :account

      t.timestamps
    end
  end
end
