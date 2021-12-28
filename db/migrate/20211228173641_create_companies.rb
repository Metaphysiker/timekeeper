class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name, default: ""
      t.string :email, default: ""

      t.timestamps
    end
  end
end
