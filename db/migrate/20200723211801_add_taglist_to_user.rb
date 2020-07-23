class AddTaglistToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :taglist, :string, array: true
  end
end
