# == Schema Information
#
# Table name: favourite_questions
#
#  id          :integer          not null, primary key
#  question_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# +-------------+----------+
# |  Favourite_questions   |
# +-------------+----------+
# | Name        | Type     |
# +-------------+----------+
# | id          | integer  |
# | question_id | integer  |
# | user_id     | integer  |
# | created_at  | datetime |
# | updated_at  | datetime |
# +-------------+----------+

class FavouriteQuestion < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
end
