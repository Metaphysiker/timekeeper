class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, default: ""
      t.belongs_to :account

      t.timestamps
    end
  end
end
