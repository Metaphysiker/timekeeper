class AddDateToWorkTime < ActiveRecord::Migration[6.1]
  def change
    add_column :work_times, :datetime, :datetime
  end
end
