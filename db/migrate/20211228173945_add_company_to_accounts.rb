class AddCompanyToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_reference :accounts, :account, foreign_key: true
  end
end
