class CreateReputationTransactions < ActiveRecord::Migration
  def change
    create_table :reputation_transactions do |t|
      t.integer :user_id, :limit => 8, :null => false
      t.integer :winner_id, :limit => 8, :default => 0
      t.integer :question_id, :limit => 8, :null => false
      t.integer :answer_id, :limit => 8, :default => 0
      t.integer :reputation, :null => false
      t.integer :trade_type, :default => 1
      #1 new question
      #2 winning
      t.timestamps
    end
  end
end
