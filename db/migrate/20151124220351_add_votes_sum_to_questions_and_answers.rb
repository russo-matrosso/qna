class AddVotesSumToQuestionsAndAnswers < ActiveRecord::Migration
  def change
    add_column :questions, :votes_sum, :integer
    add_column :answers, :votes_sum, :integer
  end
end
