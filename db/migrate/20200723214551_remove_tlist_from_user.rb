class RemoveTlistFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :tlist, :tag
  end
end
