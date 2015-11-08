class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions
  has_many :answers
  has_many :favourite_questions
  has_many :favourites, through: :favourite_questions, source: :question

  def add_favourite(question)
    self.favourites << question unless self.favourited?(question)
  end

  def favourited?(question)
    self.favourites.include?(question)
  end
end
