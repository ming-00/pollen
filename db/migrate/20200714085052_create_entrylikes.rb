class CreateEntrylikes < ActiveRecord::Migration[5.2]
  def change
    create_table :entrylikes do |t|
      t.references :user, foreign_key: true
      t.references :entry, foreign_key: true

      t.timestamps
    end
  end
end
