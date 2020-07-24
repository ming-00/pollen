class RemoveTaglistFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :taglist, :string
  end
end
