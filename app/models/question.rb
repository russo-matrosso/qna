class Question < ActiveRecord::Base
  include ActiveModel::Serialization

  validates :title, :body, presence: true

  belongs_to :user
  has_many :answers
  has_many :attachments, as: :attachmentable
  has_many :favourite_questions
  has_many :favourited_by, through: :favourite_questions, source: :user

  accepts_nested_attributes_for :attachments
end
