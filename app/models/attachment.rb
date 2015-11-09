# == Schema Information
#
# Table name: attachments
#
#  id                  :integer          not null, primary key
#  file                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  attachmentable_id   :integer
#  attachmentable_type :string
#

class Attachment < ActiveRecord::Base
  mount_uploader :file, FileUploader

  belongs_to :attachmentable, polymorphic: true
end
