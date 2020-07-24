class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.string :title
      t.text :content
      t.references :journal, foreign_key: true

      t.timestamps
    end
    add_index :entries, [:journal_id, :created_at]
  end
end
