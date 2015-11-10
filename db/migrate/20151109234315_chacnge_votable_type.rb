class ChacngeVotableType < ActiveRecord::Migration
  def change
    change_table :votes do |t|
      t.change :votable_type, :string, index: true
    end
  end
end
