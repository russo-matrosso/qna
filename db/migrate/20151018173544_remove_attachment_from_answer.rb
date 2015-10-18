class RemoveAttachmentFromAnswer < ActiveRecord::Migration
  def self.up
    remove_column :attachments, :answer_id
  end
end
