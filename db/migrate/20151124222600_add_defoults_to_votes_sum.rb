class AddDefoultsToVotesSum < ActiveRecord::Migration
  def change
    change_column :questions, :votes_sum, :integer, default: 0
    change_column :answers, :votes_sum, :integer, default: 0
  end
end
