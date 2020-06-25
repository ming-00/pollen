class AddUserToCorrections < ActiveRecord::Migration[5.2]
  def change
    add_reference :corrections, :user, foreign_key: true
  end
end
