# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions
  has_many :answers
  has_many :favourite_questions
  has_many :favourites, through: :favourite_questions, source: :question
  has_many :votes
  has_many :comments


  # Favourites

  def add_favourite(question)
    self.favourites << question unless self.favourited?(question)
  end

  def remove_favourite(question)
    self.favourites.delete(question)
  end

  def favourited?(question)
    self.favourites.include?(question)
  end

  # Votes

  def vote_up_for(entry)
    entry.votes.create(user: self, vote: 1) unless self.voted_for?(entry)
  end

  def vote_down_for(entry)
    entry.votes.create(user: self, vote: -1) unless self.voted_for?(entry)
  end

  def unvote(entry)
    entry.votes.find_by(user: self).destroy if self.voted_for?(entry)
  end

  def voted_for?(entry)
    !self.votes.where(votable_id: entry.id).where( votable_type: entry.class.to_s).empty?
  end
end
