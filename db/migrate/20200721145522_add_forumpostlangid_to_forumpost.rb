class AddForumpostlangidToForumpost < ActiveRecord::Migration[5.2]
  def change
    add_column :forumposts, :forumpostlangid, :integer
  end
end
