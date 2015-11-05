class CreateFavouriteQuestions < ActiveRecord::Migration
  def change
    create_table :favourite_questions do |t|
      t.integer :question_id, index: true
      t.integer :user_id, index: true

      t.timestamps null: false
    end
  end
end
