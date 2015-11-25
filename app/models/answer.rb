# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  body        :text
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  votes_sum   :integer          default(0)
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#  index_answers_on_user_id      (user_id)
#  index_answers_on_votes_sum    (votes_sum)
#

class Answer < ActiveRecord::Base
  include ActiveModel::Serialization

  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachmentable
  has_many :votes, as: :votable
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :attachments

  validates :body, presence: true
end
