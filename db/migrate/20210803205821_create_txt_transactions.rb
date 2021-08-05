class CreateTxtTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :txt_transactions do |t|

      t.timestamps
    end
  end
end
