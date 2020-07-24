class CreateFluencies < ActiveRecord::Migration[5.2]
  def change
    create_table :fluencies do |t|
      t.integer :level
      t.references :user, foreign_key: true
      t.references :language, foreign_key: true

      t.timestamps
    end
  end
end
