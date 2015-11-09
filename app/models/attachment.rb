# +---------------------+----------+
# |          Attachments           |
# +---------------------+----------+
# | Name                | Type     |
# +---------------------+----------+
# | id                  | integer  |
# | file                | string   |
# | created_at          | datetime |
# | updated_at          | datetime |
# | attachmentable_id   | integer  |
# | attachmentable_type | string   |
# +---------------------+----------+

class Attachment < ActiveRecord::Base
  mount_uploader :file, FileUploader

  belongs_to :attachmentable, polymorphic: true
end
