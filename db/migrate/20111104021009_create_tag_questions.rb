class CreateTagQuestions < ActiveRecord::Migration
  def change
    create_table :tag_questions do |t|
      t.integer :tag_id, :null => false
      t.integer :question_id, :limit => 8, :null => false

      t.timestamps
    end
  end
end
