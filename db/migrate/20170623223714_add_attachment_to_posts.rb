class AddAttachmentToPosts < ActiveRecord::Migration
  def up
    add_attachment :posts, :attachment
  end

  def down
    remove_attachment :posts, :attachment
  end
end
