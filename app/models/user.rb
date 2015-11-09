# +------------------------+----------+
# |               Users               |
# +------------------------+----------+
# | Name                   | Type     |
# +------------------------+----------+
# | id                     | integer  |
# | created_at             | datetime |
# | updated_at             | datetime |
# | email                  | string   |
# | encrypted_password     | string   |
# | reset_password_token   | string   |
# | reset_password_sent_at | datetime |
# | remember_created_at    | datetime |
# | sign_in_count          | integer  |
# | current_sign_in_at     | datetime |
# | last_sign_in_at        | datetime |
# | current_sign_in_ip     | inet     |
# | last_sign_in_ip        | inet     |
# +------------------------+----------+

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions
  has_many :answers
  has_many :favourite_questions
  has_many :favourites, through: :favourite_questions, source: :question

  def add_favourite(question)
    self.favourites << question unless self.favourited?(question)
  end

  def remove_favourite(question)
    self.favourites.delete(question)
  end

  def favourited?(question)
    self.favourites.include?(question)
  end
end
