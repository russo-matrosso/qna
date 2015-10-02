class AddQuestionsToUsers < ActiveRecord::Migration
  def change
    change_table :questions do |t|
      t.belongs_to :user, index: true
    end
  end
end
