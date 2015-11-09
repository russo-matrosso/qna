# +-------------+----------+
# |        Answers         |
# +-------------+----------+
# | Name        | Type     |
# +-------------+----------+
# | id          | integer  |
# | body        | text     |
# | question_id | integer  |
# | created_at  | datetime |
# | updated_at  | datetime |
# | user_id     | integer  |
# +-------------+----------+

class Answer < ActiveRecord::Base
  include ActiveModel::Serialization

  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachmentable

  accepts_nested_attributes_for :attachments

  validates :body, presence: true
end
