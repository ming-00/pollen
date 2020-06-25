class CreateCorrections < ActiveRecord::Migration[5.2]
  def change
    create_table :corrections do |t|
      t.text :content
      t.text :comment
      t.boolean :correct
      t.references :entry, foreign_key: true

      t.timestamps
    end
  end
end
