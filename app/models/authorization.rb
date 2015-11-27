# == Schema Information
#
# Table name: authorizations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  provider   :string
#  uid        :string
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_authorizations_on_user_id  (user_id)
#

class Authorization < ActiveRecord::Base
  belongs_to :user
end
