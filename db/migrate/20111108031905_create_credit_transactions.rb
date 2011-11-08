class CreateCreditTransactions < ActiveRecord::Migration
  def change
    create_table :credit_transactions do |t|
      t.integer :user_id, :limit => 8, :null => false
      t.integer :winner_id, :limit => 8, :default => 0
      t.integer :question_id, :limit => 8, :null => false
      t.integer :answer_id, :limit => 8, :default => 0
      t.decimal :credit, :precision => 8, :scale => 2, :default => 0.00
      t.integer :trade_type, :default => 1
      #1 new question
      #2 winning
      #3 recharging
      t.integer :trade_status, :default => 1
      #1 waiting for answer
      #2 
      t.timestamps
    end
  end
end
