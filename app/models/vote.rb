# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  vote         :integer
#  votable_id   :integer
#  votable_type :string
#  entry_class  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#
# Indexes
#
#  index_votes_on_entry_class_and_votable_type_and_votable_id  (entry_class,votable_type,votable_id)
#  index_votes_on_user_id                                      (user_id)
#

class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true
end
