class Question < ActiveRecord::Base
  include ActiveModel::Serialization

  validates :title, :body, presence: true

  belongs_to :user
  has_many :answers
  has_many :attachments, as: :attachmentable

  accepts_nested_attributes_for :attachments
end
