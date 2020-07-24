class RemoveTagslistFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :tagslist, :string
  end
end
