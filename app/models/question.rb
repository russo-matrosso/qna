class Question < ActiveRecord::Base
  validates :title, :body, presence: true

  belongs_to :user
  has_many :answers
  has_many :attachments

  accepts_nested_attributes_for :attachments
end
