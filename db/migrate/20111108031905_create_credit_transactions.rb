class CreateCreditTransactions < ActiveRecord::Migration
  def change
    create_table :credit_transactions do |t|
      t.integer :payer_id, :limit => 8, :null => false
      t.integer :receiver_id, :limit => 8, :default => 0
      t.integer :question_id, :limit => 8, :default => 0
      t.integer :answer_id, :limit => 8, :default => 0
      t.decimal :credit, :precision => 8, :scale => 2, :null => false
      t.boolean :payment, :default => true
      t.integer :trade_type, :default => 0
      t.integer :trade_status, :default => 0
      
      t.timestamps
    end
  end
end
