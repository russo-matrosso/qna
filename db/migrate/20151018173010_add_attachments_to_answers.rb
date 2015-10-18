class AddAttachmentsToAnswers < ActiveRecord::Migration
  def change
    change_table :attachments do |t|
      t.belongs_to :answer, index: true
    end
  end
end
