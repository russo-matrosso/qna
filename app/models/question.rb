# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  votes_sum  :integer          default(0)
#
# Indexes
#
#  index_questions_on_user_id    (user_id)
#  index_questions_on_votes_sum  (votes_sum)
#

class Question < ActiveRecord::Base
  include ActiveModel::Serialization

  validates :title, :body, presence: true

  belongs_to :user
  has_many :answers
  has_many :attachments, as: :attachmentable
  has_many :votes, as: :votable
  has_many :comments, as: :commentable
  has_many :favourite_questions
  has_many :favourited_by, through: :favourite_questions, source: :user

  accepts_nested_attributes_for :attachments
end
