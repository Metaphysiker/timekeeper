class AddOptionsToAccount < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :options, :text, default: ""
  end
end
