class AddTempFluencyIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :f_temp_id, :integer
  end
end
