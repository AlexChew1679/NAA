class AddAttachmentResourceToTasks < ActiveRecord::Migration
  def self.up
    change_table :tasks do |t|
      t.attachment :resource
    end
  end

  def self.down
    remove_attachment :tasks, :resource
  end
end
