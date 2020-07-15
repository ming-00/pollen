class AddAcceptedToForumposts < ActiveRecord::Migration[5.2]
  def change
    add_column :forumposts, :accepted, :boolean
  end
end
