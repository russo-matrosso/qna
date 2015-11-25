class AddIndexesToVotesSum < ActiveRecord::Migration
  def change
    add_index :questions, :votes_sum
    add_index :answers, :votes_sum
  end
end
