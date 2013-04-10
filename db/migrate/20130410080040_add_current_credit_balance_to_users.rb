class AddCurrentCreditBalanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_credit_balance, :integer
  end
end
