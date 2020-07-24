class AddTempIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :temp_id, :integer
  end
end
