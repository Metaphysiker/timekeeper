class CreateSelectOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :select_options do |t|
      t.string :name, default: ""
      t.belongs_to :category

      t.timestamps
    end
  end
end
