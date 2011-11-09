class CreateReputationTransactions < ActiveRecord::Migration
  def change
    create_table :reputation_transactions do |t|
      t.integer :user_id, :limit => 8, :null => false
      t.integer :winner_id, :limit => 8, :default => 0
      t.integer :question_id, :limit => 8, :default => 0
      t.integer :answer_id, :limit => 8, :default => 0
      t.integer :reputation, :null => false
      t.boolean :payment, :default => true
      t.integer :trade_type, :default => 0
      t.integer :trade_status, :default => 0
      t.timestamps
    end
  end
end
