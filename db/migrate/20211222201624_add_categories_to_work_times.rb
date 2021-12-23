class AddCategoriesToWorkTimes < ActiveRecord::Migration[6.1]
  def change
    add_column :work_times, :categories, :json, default: {}
  end
end
