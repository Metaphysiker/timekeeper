class AddOptionsToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :option_field, :text, default: ""
  end
end
