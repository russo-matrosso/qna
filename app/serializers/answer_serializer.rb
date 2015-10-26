class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body
  delegate :current_user, to: :scope

  has_one :user
  has_one :question

  # def attributes
  #   hash = super
  #   hash["current"] = current_user.id
  #   hash
  # end
end
