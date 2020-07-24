class AddTaglistToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tagslist, :string, array: true
  end
end
