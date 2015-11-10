class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :vote
      t.integer :votable_id
      t.integer :votable_type
      t.string :entry_class
      t.timestamps null: false
    end

    add_index :votes, [:entry_class, :votable_type, :votable_id]
  end
end
