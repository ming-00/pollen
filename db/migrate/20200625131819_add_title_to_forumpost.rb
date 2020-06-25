class AddTitleToForumpost < ActiveRecord::Migration[5.2]
  def change
    add_column :forumposts, :title, :string
  end
end
