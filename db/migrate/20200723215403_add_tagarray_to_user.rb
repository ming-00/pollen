class AddTagarrayToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tagarray, :string, array: true
  end
end
