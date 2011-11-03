class CreateCategoryQuestions < ActiveRecord::Migration
  def change
    create_table :category_questions do |t|
      t.integer :category_id, :null => false
      t.integer :question_id, :limit => 8, :null => false

      t.timestamps
    end
  end
end
