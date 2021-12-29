class AddWorkloadToAccount < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :work_load, :integer, default: 0
  end
end
